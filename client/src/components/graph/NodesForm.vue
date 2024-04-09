<script setup>
  import { defineEmits, ref
   } from 'vue';

  const emit = defineEmits(
    ['update:create-node']
  );
  const nodeName = ref('');

</script>

<template>
  <div class="flex justify-center border-2 border-gray-300 rounded-md p-2">
    <form
      @submit.prevent="emit('update:create-node', {name: nodeName})"
      class="space-x-6"
    >
      <label for="name">Node Name:</label>
      <input
        type="text"
        id="name"
        v-model="nodeName"
        class="bg-slate-600 border-2 border-gray-300 rounded-md"
      />
      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      type="submit">Create Node</button>
    </form>
  </div>
</template>

<style scoped>

</style>
