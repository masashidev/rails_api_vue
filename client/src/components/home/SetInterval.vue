<script setup>

import {ref, computed, onMounted, onUnmounted} from 'vue';

// let intervalId;
// onMounted(() => {
//   intervalId = setInterval(() => {
//     console.log('Hello from setInterval');
//   }, 2000);
// });

// onUnmounted(() => {
//   clearInterval(intervalId);
// });

const page = ref(null);

const gridData = ref([
  [1,0,1,1,0,1,0,0,1],
  [0,0,1,0,0,1,1,1,0],
  [1,0,1,1,1,0,0,0,1],
]);

function changeNumber(row, col){
  gridData.value[row][col] = gridData.value[row][col] ? 0 : 1;
}
function deleteElement () {
  gridData.value[0].pop();
}
function removeElement(event) {
  const element = event.target;
  element.remove();
}

</script>

<template>
  <div ref="page" @click="removeElement">
    <button @click="deleteElement">Delete Element</button>
    <div
      v-for="(row, index) in gridData"
      :key="index"
      class="flex justify-center"
    >
      <div
        v-for="(col, index) in row"
        :key="index"
        class="border-2 border-gray-300 rounded-md p-2"
        :class="col ? 'bg-green-500' : 'bg-red-500'"
        >
        <div
          v-if="col===1"
          class="size-4"
        >{{ col }}
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>
