import { createRouter, createWebHistory } from "vue-router";
import Appointments from "./views/Appointments.vue";
import AppointmentTypes from "./views/AppointmentTypes.vue";

const routes = [
  { path: "/", component: Appointments },
  { path: "/appointment-types", component: AppointmentTypes },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
