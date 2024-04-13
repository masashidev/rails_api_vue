<script setup>

import { ref, onMounted, watch, computed } from 'vue';
import List from '../components/test/List.vue';

const sortingOptions = ref([
  { name: "Alphbet", value: "alphabet" },
  { name: "Id", value: "id" },
  { name: "Date", value: "date" },
  { name: "Category", value : "category"}

])

const selectedSorts = ref([]);

const count = ref(0);
const data = ref(null);
const width = ref(0);
onMounted(() => {

});
function toggleData(){
  if(data.value === null){
    data.value = "data";
  }else{
    data.value = null;
  }
}
watch(data, (newVal, oldVal) => {
  console.log(newVal, oldVal);
});

const div = ref(null);
function updateWidth(){
  width.value += 10;
}
const humans = ref([
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Jake", age: 15 },
  { name: "Jill", age: 20 },
  { name: "Jack", age: 10 },
]);

const ageSortedHumans = computed(() => {
  return humans.value.slice().sort((a, b) => a.age - b.age);
});


</script>

<template>
  <List />
  <h1>humans names</h1>
  <ul>
    <li v-for="human in ageSortedHumans" :key="human.name">
      {{ human.name }} - {{ human.age }}
    </li>
  </ul>

  <p>count:{{ count }}</p>
  <div
    :style="{ width: `${width}px` }"
    ref="div"
    class="h-4 bg-red-500">a</div>
  <button @click="toggleData">Add Content</button>
  <button @click="updateWidth">Update Width</button>

  <div class="flex w-11/12 justify-center">
    <h2 class="text-2xl font-semibold m-4 inline-block whitespace-nowrap">Sort By</h2>
    <div class="h-1 w-full m-auto bg-gray-300"></div>
  </div>
  <div class="flex justify-center space-x-4 border-s-4 border-b-4 m-4">
    <button
      class="m-2 h-10 p-2 rounded-md bg-slate-700 text-white dark:bg-cyan-600"
      v-for="option in sortingOptions"
      :key="option.value"
      @click="selectedSorts.push(option.value)">
      {{ option.name }}
    </button>
  </div>



</template>

<style scoped>

</style>
