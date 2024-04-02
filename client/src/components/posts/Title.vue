<script setup>
  import { Icon } from '@iconify/vue';
  import {defineProps} from 'vue';

  const props = defineProps({
    title: String,
  });

</script>

<template>
  <div class="flex justify-center items-center space-x-2">
    <h1 class="text-center text-2xl font-bold">{{ title }}</h1>

    <Icon icon="material-symbols-light:post-add-rounded" width="32" height="32" />
  </div>
</template>

<style scoped>

</style>
