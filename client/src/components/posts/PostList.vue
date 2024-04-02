<script setup>
  import { Icon } from '@iconify/vue';
  import { defineProps } from 'vue';

  // Define props
  const props = defineProps({
    filteredPosts: Array,
    editPost: Function,
    deletePost: Function
  });
</script>

<template>
  <div class="grid grid-cols-1 gap-1 sm:grid-cols-2 xl:grid-cols-3 ">
    <div
      v-for="(post, index) in filteredPosts"
      :key="post.id"
      class="rounded-md border-2 border-gray-300 p-2 flex"
    >
      <div class="flex-1">
        <p class="text-xs">{{ index + 1 }}) {{ post.category?.name }}</p>
        <h3 class="text-lg">{{ post.body }}</h3>
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
</template>


<style scoped>
/* Add any styles specific to the PostsIndex component here */
</style>
