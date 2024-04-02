<script setup>
  import { ref, defineProps, defineEmits
  } from 'vue';

  const props = defineProps({
    categoriesUrl: String,
  });
  const emit = defineEmits({
    'category-created': null,
  });

  const newCategoryName = ref('');
  const alertMessage = ref('');
  const alertColor = ref('');

  async function createCategory() {

    if (!newCategoryName.value) {
      displayMessage('Category name is required', false);
      return;
    }

    try {
      const response = await fetch(props.categoriesUrl, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: newCategoryName.value }),
      });
      const data = await response.json();

      if (response.ok) {
        emit('category-created', data.category);
        newCategoryName.value = '';
        displayMessage(data.message, true);
      } else {
        displayMessage(data.message, false);
      }
    } catch (error) {
      console.error('Failed to create category:', error);
      displayMessage('An unexpected error occurred', false);
    }
  }

  function displayMessage(message, isSuccess) {
    alertColor.value = isSuccess ? 'green' : 'red';
    alertMessage.value = message;
    setTimeout(() => {
      alertMessage.value = '';
    }, 3000);
  };

</script>

<template>
  <div>
    <input
      class="m-4 h-10  rounded-md border-2 border-gray-300 p-2 dark:bg-slate-400 dark:text-gray-100 dark:placeholder-slate-300"
      type="text"
      v-model="newCategoryName"
      placeholder="New Category Name"
    />

    <button
      class=" border-gray-300 p-2 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
      @click="createCategory"
    >
      Add Category
    </button>

      <!-- alert message -->
    <span
      class="m-4 text-nowrap"
      :style="{ color: alertColor }"
    >
      {{ alertMessage }}
    </span>
  </div>
</template>

<style scoped>

</style>
