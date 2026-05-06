import { createRouter, createWebHistory } from 'vue-router'

import Home from '../views/Home.vue'
import SelfInfo from '@/views/SelfInfo.vue'
import SelfSalary from '@/views/SelfSalary.vue'
import StuffSalary from '@/views/StuffSalary.vue'
import StuffBonus from '@/views/StuffBonus.vue'
import StuffChecking from '@/views/StuffChecking.vue'
import StuffInfo from '@/views/StuffInfo.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/SelfInfo',
    name: 'SelfInfo',
    component: SelfInfo,
    props: true
  },
  {
    path: '/SelfSalary',
    name: 'SelfSalary',
    component: SelfSalary
  },
  {
    path: '/StuffSalary',
    name: 'StuffSalary',
    component: StuffSalary
  },
  {
    path: '/StuffBonus',
    name: 'StuffBonus',
    component: StuffBonus
  },
  {
    path: '/StuffInfo',
    name: 'StuffInfo',
    component: StuffInfo
  },
  {
    path: '/StuffChecking',
    name: 'StuffChecking',
    component: StuffChecking
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router