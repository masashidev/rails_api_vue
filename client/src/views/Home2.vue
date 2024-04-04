<script setup>

import RandomBar from '../components/home/RandomBar.vue';
import Grid from '../components/home/Grid.vue';
import RandomWord from '../components/home/RandomWord.vue';
import SetInterval from '../components/home/SetInterval.vue';

import {ref, computed } from 'vue';


const range = ref(30);
const minimum = ref(400);
const scale = ref(1);

const elements = computed(()=> {
  const pattern = [];
  for (let i = 0; i < 10; i++) {
    const width = Math.floor(Math.random() * range.value) + minimum.value;
    pattern.push({
      id: i,
      width: width,
      label: `element ${i}`});
  }
  return pattern;
})

const visible = ref(false);

const variables = ([
  "time", "length", "mass", "temperature", "current", "luminous intensity", "amount of substance", "angle", "solid angle", "amount", "duration", "ratio", "density", "velocity", "acceleration", "force", "pressure", "energy", "power", "frequency", "electric charge", "potential", "capacity", "area", "position", "sum", "average", "minimum", "width", "gap", "maximum", "height", "depth", "diameter", "radius", "circumference", "volume", "surface area", "perimeter", "flow", "direction", "speed", "rate", "level", "intensity", "brightness", "color", "shape", "form", "size", "weight", "load", "tension", "stress", "strain", "torque", "moment", "work", "momentum", "impulse", "heat", "depth", "generation", "distance", "distribution", "probability", "likelihood", "mean", "median", "mode", "variance", "standard deviation", "skewness", "kurtosis", "correlation", "covariance", "limit", "timing", "flexibility", "threshold", "accuracy", "predictability", "reliability", "validity", "consistency", "stability", "sensitivity", "specificity",
])
// node

// edge

// graph

</script>

<template>
  <!-- keyword search input bar -->

  <!-- current index of meta spatial position for variable  -->


  <!-- current view of variable list  -->



  <button @click="visible = !visible">Toggle Grid</button>


  <Grid v-if="visible" :variables="variables" />

  <RandomWord v-if="visible" />

  <SetInterval />

</template>

<style scoped>
  .big {
    font-size: 20px;
  }
</style>
