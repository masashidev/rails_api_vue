<script setup>
import { ref } from 'vue';

const mousePosition = ref({ x: 0, y: 0 });
const japaneseCharacters = [
  'あ', 'い', 'う', 'え', 'お',
  'か', 'き', 'く', 'け', 'こ',
  'さ', 'し', 'す', 'せ', 'そ',
  'た', 'ち', 'つ', 'て', 'と',
  'な', 'に', 'ぬ', 'ね', 'の',
  'は', 'ひ', 'ふ', 'へ', 'ほ',
  'ま', 'み', 'む', 'め', 'も',
  'や', 'ゆ', 'よ',
  'ら', 'り', 'る', 'れ', 'ろ',
  'わ', 'を', 'ん'
]
const display = ref(null);
const elements = ref([]);


function updateMousePosition(event) {
  const componentRect = event.target.getBoundingClientRect();
  mousePosition.value = {
    x: event.clientX + scrollX,
    y: event.clientY + scrollY
  };
}

function getRandomJapaneseCharacter() {
  return japaneseCharacters[Math.floor(Math.random() * japaneseCharacters.length)];
}

function createElement(content){
  const element = document.createElement('div');
  const fontSize = mousePosition.value.y / 10;

  element.textContent = content;
  element.style.position = 'absolute';
  element.style.fontSize = `${fontSize}px`;
  element.style.color = 'white';
  element.style.visibility = 'hidden';
  element.style.backgroundColor = 'Khaki';
  if (display.value) {
    display.value.appendChild(element);
  }

  const elementWidth = element.offsetWidth;
  const elementHeight = element.offsetHeight;
  console.log(elementWidth, elementHeight);
  const centeredLeft = mousePosition.value.x - elementWidth / 2;
  const centeredTop = mousePosition.value.y - elementHeight / 2;

  element.style.left = `${centeredLeft}px`;
  element.style.top = `${centeredTop}px`;
  element.style.visibility = 'visible';
  console.log(element.style.left, element.style.top);
}


</script>

<template>
  <div
    ref="display"
    class="h-screen w-screen border-2 border-gray-300"
    v-for = "(element, index) in elements"
    @click="createElement(getRandomJapaneseCharacter())"
  >
    <h1>Home</h1>
    {{ mousePosition}}
  </div>
</template>

<style scoped>

</style>
