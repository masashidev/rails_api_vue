<script setup>
  import { defineProps, defineEmits
   } from 'vue';

  const props = defineProps({
    sortNewestFirst: Boolean,
  });

  const emit = defineEmits(
    ['update:sortNewestFirst']
  );

  function toggleSortOrder() {
    emit('update:sortNewestFirst', !props.sortNewestFirst);
  }
</script>

<template>
  <div class="flex justify-center">
    <button
      class="m-4 h-10 w-1/3 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
      @click="toggleSortOrder"
    >
      {{ sortNewestFirst ? "Sort Oldest First" : "Sort Newest First" }}
    </button>
  </div>
</template>

<style scoped>

</style>
