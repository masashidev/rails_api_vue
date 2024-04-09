<script setup>

  import { ref } from 'vue';
  const localDeleteMode = ref(false);
  const props = defineProps({
    deleteMode: Boolean,
  });
  const emit = defineEmits(['update:deleteMode']);


</script>

<template>
  <div>
    <label class="inline-flex cursor-pointer items-center">
      <input
        type="checkbox"
        v-model="localDeleteMode"
        class="peer sr-only"
        @change="emit('update:deleteMode', localDeleteMode)"
      />

      <div
        class="peer relative h-6 w-11 rounded-full bg-gray-200 after:absolute after:start-[2px] after:top-[2px] after:h-5 after:w-5 after:rounded-full after:border after:border-gray-300 after:bg-white after:transition-all after:content-[''] peer-checked:bg-blue-600 peer-checked:after:translate-x-full peer-checked:after:border-white peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-blue-300 dark:border-gray-600 dark:bg-gray-700 dark:peer-focus:ring-blue-800 rtl:peer-checked:after:-translate-x-full"
      ></div>

      <span
        class="ms-3 text-sm font-medium text-gray-200 dark:text-gray-300"
        >Delete Mode
      </span>
      {{ localDeleteMode ? 'ON' : 'OFF' }}
      {{ props.deleteMode ? 'ON' : 'OFF' }}
    </label>
  </div>
</template>

<style scoped></style>
