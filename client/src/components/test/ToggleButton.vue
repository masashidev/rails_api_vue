<script setup>

  import { ref } from 'vue';

  const toggle = ref(false);

  const props = defineProps({
    state: Boolean,
  });
  const emit = defineEmits(['update:state']);

</script>

<template>
  <div>
    <input
      type="checkbox"
      id="toggle"
      v-model="toggle"
      @change="emit('update:state', toggle)"
    >
    <label for="toggle">Toggle</label>
    {{ toggle ? 'ON' : 'OFF' }}
    {{ props.state ? 'ON' : 'OFF' }}
  </div>
</template>

<style scoped>

</style>
