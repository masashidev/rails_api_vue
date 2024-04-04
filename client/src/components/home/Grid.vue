<script setup>
import { ref, defineProps, watch } from "vue";

const props = defineProps({
  variables: Array,
});

const amount = ref(10);

watch(() => {
  console.log(amount.value);
});
</script>

<template>
  <div>
    <h1>Grid</h1>
    <div>
      <div
        v-for="(variable, index) in props.variables"
        :key="index"
        class="inline-block rounded-md border-2 border-gray-300 p-1"
      >
        <h2>{{ variable }}</h2>
      </div>
    </div>
  </div>
  <button @click="amount++">Increment</button>
  <span>{{ amount }}</span>
  <div v-for="i in amount" :key="i"
    class="m-2 h-3 w-1/2 bg-gray-300">
  </div>

</template>

<style scoped></style>
