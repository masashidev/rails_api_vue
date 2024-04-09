<script setup>
import { ref, onMounted } from "vue";
import DeleteButton from "../components/graph/DeleteButton.vue";
import NodesList from "../components/graph/NodesList.vue";
import NodesForm from "../components/graph/NodesForm.vue";


const NODE_API_URL = "http://localhost:3000/nodes";

const nodes = ref([]);
const message = ref("");
const responseOkay = ref(false);
const deleteMode = ref(false);

onMounted(() => {
  fetchNodes();
});


async function fetchNodes() {
  try {
    const res = await fetch(NODE_API_URL);
    nodes.value = await res.json();
  } catch (error) {
    console.error("Failed to fetch nodes:", error);
  }
}

async function createNode(node) {
  try {
    const res = await fetch(NODE_API_URL, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(node),
    });
    const data = await res.json();

    if (res.ok) {
      nodes.value.push(data.node);
      responseOkay.value = true;
      message.value = data.message;
      setTimeout(() => {message.value = "";}, 3000);
    } else {
      responseOkay.value = false;
      message.value = data.errors.join(", ");
    }
  } catch (error) {
    console.error("Failed to create node:", error);
    message.value = "An unexpected error occurred";
  }
}

async function deleteNode(nodeId) {
  console.log("Deleting node:", nodeId)
  try {
    const res = await fetch(`${NODE_API_URL}/${nodeId}`, {
      method: "DELETE",
    });
    const data = await res.json();
    console.log(data);
    if (res.ok) {
      nodes.value = nodes.value.filter((node) => node.id !== nodeId);
      responseOkay.value = true;
      message.value = data.message;
      setTimeout(() => {message.value = "";}, 3000);
    } else {
      responseOkay.value = false;
      message.value = data.errors.join(", ");
    }
  } catch (error) {
    console.error("Failed to delete node:", error);
    message.value = "An unexpected error occurred";
  }
}



</script>

<template>
  <div class="m-4 p-4 space-y-4">


    <p v-if="message" :class="{ 'text-green-500': responseOkay, 'text-red-500': !responseOkay }"
      >{{ message }}
    </p>

    <NodesForm @update:create-node="createNode" />
    <DeleteButton
      :deleteMode="deleteMode"
      @update:delete-mode="deleteMode = $event"
    />
    {{ deleteMode }}
    <input type="checkbox" v-model="deleteMode" />

    <NodesList :nodes="nodes" :deleteMode="deleteMode" @delete:node="deleteNode" />

  </div>
</template>

<style scoped></style>
