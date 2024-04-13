<script setup>
  import { ref, onMounted, onUnmounted, watchEffect } from 'vue';

  const canvas = ref(null);
  const ctx = ref(null);
  const windowWidth = ref(window.innerWidth - 10);
  const windowHeight = ref(window.innerHeight);
  const A = ref({x: 200, y: 200});
  const B = ref({x: 600, y: 200});
  const t = ref(0.5);

  const n = 10;


  onMounted (() => {
    ctx.value = canvas.value.getContext('2d');
    drawCanvas();

  });
  onUnmounted(() => {
    window.removeEventListener('resize', updateWindowSize);
  });

  function drawCanvas(){
    ctx.value.clearRect(0, 0, windowWidth.value, windowHeight.value);
    drawElement(A, "A");
    drawElement(B, "B");
    for (let i = 0; i<n-1; i++){
      const t=i/n-1;
      const C = {
        x: lerp(A.value.x, B.value.x, t),
        y: lerp(A.value.y, B.value.y, t)
        };
      console.log(C);

    }
  }



  function drawElement(pos, label){

    ctx.value.beginPath();
    ctx.value.fillStyle = 'gray';
    ctx.value.strokeStyle = 'white';
    ctx.value.arc(pos.value.x, pos.value.y, 30, 0, Math.PI * 2);
    ctx.value.fill();
    ctx.value.stroke();
    ctx.value.fillStyle = 'white';
    ctx.value.textAlign = 'center';
    ctx.value.textBaseline = 'middle';
    ctx.value.font = 'bold 20px Arial';
    ctx.value.fillText(label, pos.value.x, pos.value.y);
  }

  function updateWindowSize(){
    windowWidth.value = window.innerWidth - 10;
    windowHeight.value = window.innerHeight;
  }

  function lerp(a, b, t){
    return a + (b - a) * t;
  }

</script>

<template>
  <div>
    <canvas
      class="border-4 border-gray-300"
      ref="canvas"
      :width="windowWidth"
      :height="windowHeight">
    </canvas>
  </div>
</template>

<style scoped>

</style>
