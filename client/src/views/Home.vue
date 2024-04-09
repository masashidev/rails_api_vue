<script setup>
import { ref, onMounted, onUnmounted, computed } from "vue";

const myCanvas = ref(null);
const canvasWidth = ref(300);
const canvasHeight = ref(300);
const points = ref([
  { x: 0, y: 0 },
  { x: 0, y: 290 },
  { x: 290, y: 290 },
  { x: 290, y: 0 },
]);
const dot = ref({ x: 200, y: 200, size: 10 });
const keyState = ref({
  ArrowUp: false,
  ArrowDown: false,
  ArrowLeft: false,
  ArrowRight: false,
});

let ctx;

onMounted(() => {
  if (myCanvas.value) {
    window.addEventListener("keydown", handleKeyDown);
    ctx = myCanvas.value.getContext("2d");
    update();
  }
});
onUnmounted(() => {
  window.removeEventListener("keydown", handleKeyDown);
});

function update() {
  drawBackground();
  drawDot();
  drawPoints();
}

function handleKeyDown(e){
  switch(e.key){
    case "ArrowUp":
      dot.value.y -= 10;
      console.log(dot.value.y);
      break;
    case "ArrowDown":
      dot.value.y += 10;
      break;
    case "ArrowLeft":
      dot.value.x -= 10;
      break;
    case "ArrowRight":
      dot.value.x += 10;
      break;

  }
  update();
}

function drawBackground() {
  ctx.fillStyle = "gray";
  ctx.fillRect(0, 0, canvasWidth.value, canvasHeight.value);
}

function drawDot(){
  ctx.beginPath();
  ctx.arc(dot.value.x, dot.value.y, dot.value.size, 0, Math.PI * 2);
  ctx.fillStyle = "white";
  ctx.fill();
}

function drawPoints() {
  ctx.fillStyle = "black";
  points.value.forEach((point) => {
    ctx.fillRect(point.x, point.y, 10,10);
  });
}


</script>

<template>

  <div class="flex justify-center m-4">
    <canvas ref="myCanvas" :width="canvasWidth" :height="canvasHeight"></canvas>
  </div>

</template>

<style scoped></style>
