<script setup lang="ts">
import { ref, onMounted } from "vue";
import type { Appointment } from "./interfaces";
import { GetAppointments } from "./services/AppointmentService";

const appointments = ref<Appointment[]>([]);

const getAppointments = async () => {
  try {
    const response = await GetAppointments();

    appointments.value = response.data;
  } catch (error) {
    console.error("Error fetching appointments:", error);
  }
};

onMounted(async () => {
  await getAppointments();
});
</script>

<template>
  <pre>{{ appointments }}</pre>
</template>
