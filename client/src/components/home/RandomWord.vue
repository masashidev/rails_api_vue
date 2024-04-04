<script setup>
  import { ref } from 'vue';
  const rows = 10;
  const cols = 5

</script>

<template>
  <div class="inline-block">
    <div
      v-for="i in 4"
      class=" flex justify-center border-2 border-gray-300 rounded-md p-2">
        <div
          v-for="j in 5"
          class="border-2 border-gray-300 rounded-md p-2"
          >
          <div
            v-for="k in 3"
            class="flex justify-center">

            <div
              v-for="l in 3"
              class="size-6 bg-slate-400 rounded-full">
            </div>
          </div>

        </div>
    </div>

  </div>
</template>

<style scoped>

</style>
