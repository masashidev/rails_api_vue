import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import Home2 from '../views/Home2.vue'
import PostsManager from "../views/PostsManager.vue";
import Graph from "../views/Graph.vue";
import Test from "../views/Test.vue";

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
  },
  {
    path: '/graph',
    name: 'Graph',
    component: Graph
  },
  {
    path: '/test',
    name: 'Test',
    component: Test
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
