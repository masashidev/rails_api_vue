<script setup>
import { ref, onMounted, computed, watchEffect} from "vue";
import { Icon } from '@iconify/vue';

import Title from '../components/posts/Title.vue';
import PasswordInput from '../components/posts/PasswordInput.vue';
import DarkModeToggle from '../components/posts/DarkModeToggle.vue';
import CategoryInput from '../components/posts/CategoryInput.vue';
import CategoryList from '../components/posts/CategoryList.vue';
import PostsIndex from '../components/posts/PostsIndex.vue';
import PostsSortButton from '../components/posts/PostsSortButton.vue';
import PostsSearchInput from '../components/posts/PostsSearchInput.vue';
import PostsList from '../components/posts/PostList.vue';


// global variables
const API_URL = "http://localhost:3000/posts";
const CATEGORIES_URL = "http://localhost:3000/categories";


const posts = ref([]);
const categories = ref([]);

const post_id = ref("");
const body = ref("");
const selectedCategory = ref("");

const isEditing = ref(false);

const password = ref("");

// categories logic

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
  } catch (error) {
    console.error('Failed to fetch categories:', error)
  }
});

function handleCategoryCreated(category) {
  categories.value.push(category);
}




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

function handleSubmit (submittedPassword) {
  console.log('Password:', submittedPassword);
}
</script>











<template>
  <div
    class="m-4 rounded-md border-2 border-gray-300 p-4 sm:container sm:mx-auto"
  >
    <DarkModeToggle />
    <!-- title -->
    <Title title="Posts Manager" />

    <PasswordInput v-model="password" @submit-success="handleSubmit" />
    <p> password:{{ password }} </p>

    <!-- <StatusUpdate v-model="status" /> -->

    <!-- categories div -->
    <div class="border-2 border-gray-300 p-4 rounded-lg my-4">
      <h3 class="text-lg font-bold">Create Categories</h3>
      <!-- categories input -->
      <CategoryInput :categoriesUrl="CATEGORIES_URL" @category-created="handleCategoryCreated" />
      <!-- categories list -->
      <CategoryList :sortedCategories="sortedCategories" />
    </div>



    <!-- creating post div -->
    <div class="border-2 border-gray-300 p-4 rounded-lg">
      <h3 class="text-lg font-bold">Create Post</h3>

      <!-- post input bar -->
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

    <!-- index for posts -->
    <PostsIndex :numPosts="numPosts" :numCategories="numCategories" />

    <!-- posts search input -->
    <PostsSearchInput v-model="searchQuery" />
    <p>searchquery:{{ searchQuery }}</p>

    <!-- category search input -->
    <input
      class="m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text"
      placeholder="Search Categories"
    />

    <!-- sort posts button -->
    <PostsSortButton
      :sortNewestFirst="sortNewestFirst"
      @update:sortNewestFirst="sortNewestFirst = $event"
    />

    <!-- posts index-->
    <PostsList
      :filteredPosts="filteredPosts"
      :editPost="editPost"
      :deletePost="deletePost"
    />
  </div>
</template>

<style scoped></style>
