<script setup>
// import { } from '';

// Reactive state

// Computed properties

// Watchers

// Lifecycle hooks

// Methods

</script>

<template>
  <div>

    <input type="range" v-model="range" min="0" max="100" step="1"
    ><span>range</span>{{range}}
    <input type="range" v-model="minimum" min="0" max="1000" step="1"
    /><span>minimum</span>{{minimum}}
    <input type="range" v-model="scale" min="0" max="10" step="0.1"
    /><span>scale</span>{{scale}}


    <div>
      <div
        class="h-4 bg-slate-400"
        v-for="element in elements"
        :key="element.id"
        :style="{ width: `${element.width}px` }"
      ><span>{{element.width}}</span>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>
