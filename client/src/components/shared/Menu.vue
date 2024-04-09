<script setup>


</script>

<template>
  <div class="w-11/12 m-auto">
    <div class="flex space-x-4 m-2">
      <h1>Menu</h1>
      <ol class="flex space-x-4">
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/posts">Posts</router-link></li>
        <li><router-link to="/graph">Graph</router-link></li>
        <li><router-link to="/test">Test</router-link></li>
      </ol>
    </div>

    <div class="h-2 bg-gray-300"></div>
  </div>
</template>

<style scoped>

</style>
