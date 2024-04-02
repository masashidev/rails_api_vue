<script setup>
  import { defineProps, defineEmits } from 'vue';

  const props = defineProps({
    modelValue: String,
  });

  const emit = defineEmits(['update:modelValue', 'submit-success']);

  function updatePassword(event) {
    emit('update:modelValue', event.target.value);
  };

  function submitForm() {
    emit('submit-success', props.modelValue)
  }

</script>

<template>
  <div>
    <form @submit.prevent="submitForm">
      <label for="password">Password</label>
      <input
        type="password"
        id="password"
        :value="props.modelValue"
        @input="updatePassword" />
      <button type="submit">Submit</button>
    </form>
  </div>
</template>

<style scoped>

</style>
