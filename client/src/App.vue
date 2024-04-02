<script setup>
  import Menu from './components/shared/Menu.vue';
</script>

<template>
  <div>
    <Menu />
    <router-view />
  </div>
</template>

<style>
  .dark{
  background-color: #18191a;
  color: #e4e6eb;
  border-color: #e4e6eb;
  }
</style>
