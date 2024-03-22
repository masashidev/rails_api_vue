<script setup>
import { ref, onMounted } from "vue";
import { Icon } from '@iconify/vue';

const posts = ref([]);

const category = ref("");
const body = ref("");
const post_id = ref("");
const isEditing = ref(false);
const API_URL = "http://localhost:3000/posts";





// categories logic
const categories = ref([]);

onMounted(async () => {
  await fetchCategories();
  const res = await fetch(API_URL);
  posts.value = await res.json();
});

async function fetchCategories() {
  const categoriesUrl = 'http://localhost:3000/categories'; // Adjust the URL to your categories endpoint
  const res = await fetch(categoriesUrl);
  categories.value = await res.json();
}






// posts logic
onMounted(async () => {
  const res = await fetch(API_URL);
  posts.value = await res.json();
});

async function createPost() {
  const res = await fetch(API_URL, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      category_id: category.value,
      body: body.value,
    }),
  });

  const data = await res.json();
  posts.value.push(data);
  category.value = "";
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
      category_id: category.value,
      body: body.value,
      id: post_id.value,
    }),
  });

  const data = await res.json();

  const index = posts.value.findIndex((post) => post.id === data.id);
  posts.value[index] = data;

  category.value = "";
  body.value = "";
  post_id.value = "";
  isEditing.value = false;
}

function cancelEdit() {
  category.value = "";
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

  category.value = post.category;
  body.value = post.body;
  post_id.value = post.id;
  isEditing.value = true;

  window.scrollTo({ top: 0, behavior: "smooth"});
}

</script>








<template>
  <div
    class="m-4 rounded-md border-2 border-gray-300 p-4 sm:container sm:mx-auto"
  >

    <!-- title -->
    <div class="flex justify-center items-center space-x-2">
      <h1 class="text-center text-2xl font-bold">Posts</h1>
      <Icon icon="mdi-light:home" />
      <Icon icon="ic:baseline-house" />
    </div>



    <!-- input bar -->
    <div class="flex flex-col sm:flex-row space-y-4">
      <!-- options for selecting categories -->
      <select
        class="m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 sm:w-1/2"
        v-model="category"
      >
        <option value="" disabled selected>Select a category</option>
        <option
          v-for="cat in categories"
          :key="cat.id"
          :value="cat.id"
          >{{ cat.name }}
        </option>
      </select>
      {{ category }}
      <input
        type="text"
        class="mx-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 sm:w-1/2"
        placeholder="Body"
        v-model="body"
      />
    </div>



    <!-- buttons -->
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
        class="m-4 h-10 w-1/3 rounded-md bg-blue-500 text-white"
      >
        Create
      </button>
    </div>



    <!-- posts -->
    <div class="grid grid-cols-1 gap-1  sm:grid-cols-2 xl:grid-cols-3 ">
      <div
        v-for="post in posts"
        :key="post.id"
        class="rounded-md border-2 border-gray-300 p-2 flex"
      >
        <div class="flex-1">
          <p class="text-xs"
          >{{ post.id }}) {{ post.category_id }}</p>
          <h3 class="text-lg"
          >{{ post.body }}</h3>
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
