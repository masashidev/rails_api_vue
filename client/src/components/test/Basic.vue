<script setup>
  import { ref, computed } from 'vue';

  const people = ref([
    {id:1, name: 'John', age: 25, connectedTo: [2,3]},
    {id:2, name: 'Jane', age: 30, connectedTo: [1,3]},
    {id:3, name: 'Jake', age: 35, connectedTo: [1,2]},
    {id:4, name: 'Jill', age: 40, connectedTo: [1,2,3]},
    {id:5, name: 'Jack', age: 45, connectedTo: [1,2,3,4]},
    {id:6, name: 'Jen', age: 50, connectedTo: [1,2,3,4,5]},
  ]);

  const connectedTo = computed (() => {
    return people.value.map(person => {
      return person.connectedTo.map(connection => {
        return people.value.find(p => p.id === connection).name;
      });
    });
  });


</script>

<template>
  <div class="m-4 p-4">
    <h1>People</h1>
    <ul class="border-2 border-gray-300 rounded-md p-2">
      <li v-for="person in people" :key="person.id">
        {{ person.name }} - {{ person.age }}

      </li>
    </ul>
    <ul>
      <li
        class="border-b-2 border-gray-300 p-2"
        v-for="(connections, index) in connectedTo" :key="index">
        {{ people[index].name }} is connected to: {{ connections.join(', ') }}
      </li>
    </ul>
  </div>
</template>

<style scoped>

</style>
