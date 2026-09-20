<template>
  <div
    class="bg-white fixed left-5 top-5 bottom-5 p-4 rounded-xl w-72 border border-gray-200 overflow-y-auto"
  >
    hola
  </div>
</template>
<script setup lang="ts">
const sidebarMenuItems = [
  {
    name: "Appointments",
    icon: "calendar",
    route: "/",
  },
  {
    name: "Appointment Types",
    icon: "list",
    route: "/appointment-types",
  },
];
</script>
