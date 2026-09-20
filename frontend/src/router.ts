import { createRouter, createWebHistory } from "vue-router";
import Appointments from "./views/Appointments.vue";

const routes = [{ path: "/", component: Appointments }];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
