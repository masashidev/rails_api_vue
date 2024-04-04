import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import Home2 from '../views/Home2.vue'
import PostsManager from "../views/PostsManager.vue";

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/home2',
    name: 'Home2',
    component: Home2
  },
  {
    path: '/posts',
    name: 'PostsManager',
    component: PostsManager
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
