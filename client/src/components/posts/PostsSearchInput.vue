<script setup>
  import { defineProps, defineEmits } from "vue";

  const props = defineProps({
    modelValue: String,
  });

  const emit = defineEmits(["update:modelValue"]);

  function updateSearch(event) {
    emit("update:modelValue", event.target.value);
    console.log(props.modelValue);
  }
</script>

<template>
  <div>
    <input
      class="search-input m-4 h-10 w-11/12 rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text"
      placeholder="Search Posts"
      :value="props.modelValue"
      @input="updateSearch"
    />
  </div>
</template>

<style scoped>
.search-input {
  /* Add specific styles for the search input here */
}
</style>
