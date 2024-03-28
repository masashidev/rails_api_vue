<script setup>
import { ref, onMounted, computed, watchEffect} from "vue";
import { Icon } from '@iconify/vue';

// darkmode logic
const isDarkMode = ref(true);
function toggleDarkMode() {
  isDarkMode.value = !isDarkMode.value;
};
watchEffect(() => {
  document.body.classList.toggle('dark', isDarkMode.value);
});


const posts = ref([]);

const selectedCategory = ref("");
const body = ref("");
const post_id = ref("");
const isEditing = ref(false);
const API_URL = "http://localhost:3000/posts";
const CATEGORIES_URL = "http://localhost:3000/categories";

const newCategoryName = ref('');

const alertMessage = ref('');
const alertColor = ref('');

// categories logic
const categories = ref([]);

const sortedCategories = computed(() => {
  return categories.value
    .slice()
    .sort((a, b) => a.name.localeCompare(b.name))
    .map(category => ({
      ...category,
      name: category.name[0].toUpperCase() + category.name.slice(1)
    }));
});

onMounted(async () => {
  try {
    const res = await fetch(CATEGORIES_URL);
    categories.value = await res.json();
    console.log('Fetched categories:', categories.value)
  } catch (error) {
    console.error('Failed to fetch categories:', error)
  }
});

async function createCategory() {

  if (!newCategoryName.value) {
    displayMessage('Category name is required', false);
    return;
  }

  try {
    const response = await fetch(CATEGORIES_URL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ name: newCategoryName.value }),
    });
    const data = await response.json();

    if (response.ok) {
      categories.value.push(data.category);
      newCategoryName.value = '';
      displayMessage(data.message, true);
    } else {
      displayMessage(data.message, false);
    }
  } catch (error) {
    console.error('Failed to create category:', error);
    displayMessage('An unexpected error occurred', false);
  }
}

function displayMessage(message, isSuccess) {
  alertColor.value = isSuccess ? 'green' : 'red';
  alertMessage.value = message;
  setTimeout(() => {
    alertMessage.value = '';
  }, 3000);

};


// posts logic
onMounted(async () => {
  try{
    const res = await fetch(API_URL);
    posts.value = await res.json();
    console.log('Fetched posts:', posts.value)
  } catch (error) {
    console.error('Failed to fetch posts:', error)
  }
});

async function createPost() {
  if (!selectedCategory.value || !body.value) {
    alert('Please select a category and enter a body');
    return;
  }

  const res = await fetch(API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      category_id: selectedCategory.value,
      body: body.value,
    }),
  });

  const data = await res.json();
  posts.value.push(data);
  // selectedCategory.value = "";
  body.value = "";
  post_id.value = "";
}

async function updatePost() {
  const res = await fetch(`${API_URL}/${post_id.value}`, {
    method: "PUT",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      category_id: selectedCategory.value,
      body: body.value,
      id: post_id.value,
    }),
  });

  const data = await res.json();

  const index = posts.value.findIndex((post) => post.id === data.id);
  posts.value[index] = data;

  selectedCategory.value = "";
  body.value = "";
  post_id.value = "";
  isEditing.value = false;
}



async function deletePost(id) {
  await fetch(`${API_URL}/${id}`, {
    method: "DELETE",
  });
  posts.value = posts.value.filter((post) => post.id !== id);
}

async function editPost(id) {
  const post = posts.value.find((post) => post.id === id );

  selectedCategory.value = post.category;
  body.value = post.body;
  post_id.value = post.id;
  isEditing.value = true;

  window.scrollTo({ top: 0, behavior: "smooth"});
}

function cancelEdit() {
  selectedCategory.value = "";
  body.value = "";
  post_id.value = "";
  isEditing.value = false;
}


// search logic
const searchQuery = ref('');
const sortNewestFirst = ref(true);
const filteredPosts = computed(() => {
  const sortedPosts = posts.value.sort((a, b) => {
    return sortNewestFirst.value
      ? b.created_at.localeCompare(a.created_at)
      : a.created_at.localeCompare(b.created_at);
  });

  if (!searchQuery.value) {
    return sortedPosts;
  }

  const lowerSearchQuery = searchQuery.value.toLowerCase();
  return sortedPosts.filter(post => {
    return post.body.toLowerCase().includes(lowerSearchQuery);
  });
});

// number of posts
const numPosts = computed(() => posts.value.length);
// number of categories
const numCategories = computed(() => categories.value.length);

</script>








<template>
  <div
    class="m-4 rounded-md border-2 border-gray-300 p-4 sm:container sm:mx-auto"
  >
    <!-- darkmode button -->
    <button @click="toggleDarkMode">
      <!-- use different icons for light and dark mode -->
      <Icon v-if = "!isDarkMode" icon="material-symbols-light:dark-mode-outline" width="32" />
      <Icon v-else = "isDarkMode" icon="material-symbols-light:light-mode-outline" width="32" color="yellow"/>
    </button>

    <!-- title -->
    <div class="flex justify-center items-center space-x-2">
      <h1 class="text-center text-2xl font-bold">Posts</h1>
      <Icon icon="material-symbols-light:post-add-rounded" width="32" height="32" />
    </div>

    <!-- categories input -->
    <div>
      <input class="m-4 h-10  rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text" v-model="newCategoryName" placeholder="New Category Name" />
      <button class=" border-gray-300 p-2 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
      @click="createCategory">Add Category</button>

       <!-- alert message -->
      <span class="m-4 text-nowrap"
        :style="{ color: alertColor }">
        {{ alertMessage }}
      </span>

    </div>

    <!-- categories list -->
    <div class="flex flex-wrap justify-center">
      <span
        v-for="cat in sortedCategories"
        :key="cat.id"
        class="m-2 p-2 rounded-md border-2 border-gray-300"
      >
        {{ cat.name }}
      </span>
    </div>


    <!-- creating post div -->
    <div class="border-2 border-gray-300 p-4 rounded-lg">
      <h3 class="text-lg font-bold">Create Post</h3>

      <!-- input bar -->
      <div class="flex flex-col sm:flex-row space-y-4">
        <!-- options for selecting categories -->
        <select
          class="m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 sm:w-1/2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
          v-model="selectedCategory"
        >
          <option value="" disabled selected>Select a category</option>
          <option
            v-for="cat in sortedCategories"
            :key="cat.id"
            :value="cat.id"
            >{{ cat.name }}
          </option>
        </select>
        {{ selectedCategory }}
        <input
          type="text"
          class="mx-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 sm:w-1/2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
          placeholder="Body"
          v-model="body"
        />
      </div>



      <!-- post operation buttons -->
      <div class="justify-center flex">
        <button
          v-if="isEditing"
          @click="updatePost"
          class="m-4 h-10 w-1/3 rounded-md bg-blue-500 text-white"
        >
          Update
        </button>
        <button
          v-if="isEditing"
          @click="cancelEdit"
          class="m-4 h-10 w-1/3 rounded-md bg-blue-500 text-white"
        >
          Cancel
        </button>

        <button
          v-else
          @click="createPost"
          class="m-4 h-10 w-1/3 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
        >
          Create
        </button>
      </div>

    </div>
    <div class="flex justify-center">
      <!-- number of posts -->
      <p class="m-4">Number of Posts: {{ numPosts }}</p>
      <!-- number of categories -->
      <p class="m-4">Number of Categories: {{ numCategories }}</p>
    </div>

    <!-- posts search input -->
    <input
      class="m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text"
      placeholder="Search Posts"
      v-model="searchQuery"
    />
    <!-- category search input -->
    <input
      class="m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text"
      placeholder="Search Categories"
    />

    <!-- sort posts -->
    <div class="flex justify-center">
      <button
        class="m-4 h-10 w-1/3 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
        @click="sortNewestFirst = !sortNewestFirst"
      >
        {{ sortNewestFirst ? "Sort Oldest First" : "Sort Newest First" }}
      </button>
    </div>

    <!-- posts -->
    <div class="grid grid-cols-1 gap-1  sm:grid-cols-2 xl:grid-cols-3 ">
      <div
        v-for="(post, index) in filteredPosts"
        :key="post.id"
        class="rounded-md border-2 border-gray-300 p-2 flex"
      >
        <div class="flex-1">
          <p class="text-xs"
          >{{ index + 1 }}) {{ post.category?.name }}</p>
          <h3 class="text-lg"
          >{{ post.body }}</h3>
          <p>{{ post.created_at.toString().slice(0, 10) }}</p>
        </div>

        <div class="flex justify-end">
          <button
            class="m-2 p-1  rounded-md bg-blue-500 text-white"
            @click="editPost(post.id)"
          >
            <icon icon="mdi-light:pencil" />
          </button>
          <button
            class="m-2 p-1 rounded-md bg-red-500 text-white"
            @click="deletePost(post.id)"
          >
            <icon icon="ic:baseline-delete-forever" />
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
