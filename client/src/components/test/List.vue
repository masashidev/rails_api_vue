<script setup>

import { ref, onMounted, onUnmounted} from 'vue';

class Item {
  constructor(id, name) {
    this.id = id;
    this.name = name;
  }
}
const list = ref([
  { id: 1, name: 'Item 1' },
  { id: 2, name: 'Item 2' },
  { id: 3, name: 'Item 3' },
  { id: 4, name: 'Item 4' },
  { id: 5, name: 'Item 5' },
]);

const newItemName = ref('');

onMounted(() => {

});
onUnmounted(() => {

});

function addNewItem() {
  const id = list.value.length + 1;
  list.value.push(new Item(id, newItemName.value));
  newItemName.value = '';
}


</script>

<template>
  <form
    @submit.prevent="addNewItem"
    class="flex justify-center border-2 border-gray-300 rounded-md p-2"
  >
    <label for="name">Item Name:</label>
    <input
      type="text"
      id="name"
      class="bg-slate-600 border-2 border-gray-300 rounded-md"
      v-model="newItemName"
    />
    <button
      class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
      type="submit"
    >
      Add Item
    </button>
  </form>
  <div
    class="m-4 p-4 border-2 border-gray-300 rounded-md">
    <ul>
      <li
        :class="[item.id % 2 === 0 ? 'bg-slate-400' : 'bg-slate-600']"
        v-for="item in list" :key="item.id">
        {{ item.name }}
      </li>
    </ul>
  </div>
</template>

<style scoped>

</style>
