<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import ToggleButton from "../components/test/ToggleButton.vue";

const state = ref(false);
const size = ref(10);
const minimumSize = ref(10);
const maximumSize = ref(400);
const frameNumber = ref(0);
const stateWords = ref(["bigger", "smaller"]);

onMounted(() => {
  // update();
});

function update() {
  if (state.value === true && size.value < maximumSize.value) {
    incrementSize();
  } else if (state.value === false && size.value > minimumSize.value) {
    decrementSize();
  }
  frameNumber.value += 1;
  console.log(frameNumber.value);
  requestAnimationFrame(update);
}

function incrementSize() {
  console.log(size.value);
  size.value += 1;
}
function decrementSize() {
  console.log(size.value);
  size.value -= 1;
}
</script>

<template>
  <div>
    <ToggleButton :state="state" @update:state="state = $event" />

    <div class="border-2 border-gray-300 p-2 rounded-md inline-block fixed top-1/2 left-10">
      size:{{ size }}
    </div>
    <div>
      <h1
        class="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 transform"
        :style="{ fontSize: `${size}px` }"
        @click="state = !state"
      >
        <span>{{ stateWords[state ? 0 : 1] }}</span>
      </h1>
    </div>
  </div>
</template>

<style scoped></style>
