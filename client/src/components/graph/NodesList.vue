<script setup>
import { ref, defineProps, defineEmits
 } from 'vue';
import { Icon } from '@iconify/vue';

const props = defineProps({
  nodes: Array,
  deleteMode: Boolean,
});

const emit = defineEmits(['delete:node']);

</script>

<template>
  <div>
    <h1>Graph</h1>
    {{ deleteMode }}
    <div>
      <div
        v-for="(node, index) in nodes"
        :key="node.id"
        class="inline-block rounded-md border-2 border-gray-300 p-1 cursor-pointer hover:scale-110 transition"
        draggable="true"
        :class="{'bg-red-900': deleteMode}"
        @click="deleteMode ? emit('delete:node', node.id) : null"
      >
        <div class="flex justify-between align-middle">
          <p>{{ node.id }}:</p>
          <p>{{ node.name }}</p>
          <span class="hover:text-yellow-400 hover:scale-150 transition">
            <icon v-if="node.is_favorite"
            icon="ic:sharp-star-purple500" />
            <icon v-else
            icon="ic:sharp-star-border" />
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>
