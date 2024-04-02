import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import PostsManager from "../views/PostsManager.vue";

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  }
  ,{
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
