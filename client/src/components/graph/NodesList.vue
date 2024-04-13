<script setup>
import { ref, defineProps, defineEmits
 } from 'vue';
import { Icon } from '@iconify/vue';

const props = defineProps({
  NODE_API_URL: String,
  nodes: Array,
  deleteMode: Boolean,
});

const emit = defineEmits(['delete:node', 'update:node']);

async function toggleFavorite(node){
  if (props.deleteMode) return;

  node.is_favorite = !node.is_favorite;

  try{
    console.log("Toggling favorite:", node.id, props.NODE_API_URL);
    const response = await fetch(`${props.NODE_API_URL}/${node.id}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ is_favorite: node.is_favorite }),
    });

    const data = await response.json();

    if (!response.ok) {
      node.is_favorite = !node.is_favorite;
      console.error("Failed to update node:", data.errors.join(", "));
    }

    emit('update:node', node);
  } catch (error) {
    console.error("Failed to update node:", error);
  }
}
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
          <span
            @click="toggleFavorite(node)"
            class="hover:text-yellow-400 hover:scale-150 transition">
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
