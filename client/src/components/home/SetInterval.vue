<script setup>

import {ref, computed, onMounted, onUnmounted} from 'vue';


onMounted(() => {
  const intervalId = setInterval(() => {
    console.log('Hello from setInterval');
  }, 2000);
});

onUnmounted(() => {
  clearInterval(intervalId);
});



</script>

<template>
  <div>

  </div>
</template>

<style scoped>

</style>
