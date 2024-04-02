<script setup>
  import { defineProps } from 'vue';
  const props = defineProps({
    numPosts: Number,
    numCategories: Number
  });
</script>

<template>
  <div class="flex justify-center">
    <!-- number of posts -->
    <p class="m-4">Number of Posts: {{ numPosts }}</p>
    <!-- number of categories -->
    <p class="m-4">Number of Categories: {{ numCategories }}</p>
  </div>
</template>

<style scoped>

</style>
