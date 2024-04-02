<script setup>
  import { computed, defineProps
   } from 'vue';

  const props = defineProps({
    sortedCategories: Array,
  });

</script>

<template>
    <div class="flex flex-wrap justify-center">
      <span
        v-for="cat in props.sortedCategories"
        :key="cat.id"
        class="m-2 p-2 rounded-md border-2 border-gray-300"
      >
        {{ cat.name }}
      </span>
  </div>
</template>

<style scoped>

</style>
