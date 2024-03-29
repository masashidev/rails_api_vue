<script setup>
  import { ref, watchEffect } from 'vue';
  import { Icon } from '@iconify/vue';

  // darkmode logic
  const isDarkMode = ref(true);

  function toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  };
  
  watchEffect(() => {
    document.body.classList.toggle('dark', isDarkMode.value);
  });
</script>

<template>
  <div>
    <!-- darkmode button -->
    <button @click="toggleDarkMode">
      <!-- use different icons for light and dark mode -->
      <Icon v-if = "!isDarkMode" icon="material-symbols-light:dark-mode-outline" width="32" />
      <Icon v-else = "isDarkMode" icon="material-symbols-light:light-mode-outline" width="32" color="yellow"/>
    </button>
  </div>
</template>

<style scoped>

</style>
