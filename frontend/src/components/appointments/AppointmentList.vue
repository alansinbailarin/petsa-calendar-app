<template>
  <div v-if="loading">
    <div class="w-full h-screen flex justify-center items-center">
      <Spinner />
    </div>
  </div>
  <div v-else>
    <section v-if="appointments.length > 0" class="flex flex-col gap-3 mt-6">
      <AppointmentItem
        :appointment="appointment"
        v-for="appointment in appointments"
        :key="appointment.id"
        :appointmentTypes="appointmentTypes"
        @updated="updateAppointments"
        :persons="persons"
      />
    </section>
    <section v-else class="w-full h-screen flex justify-center items-center">
      <EmptyState
        title="No hay citas disponibles"
        subtitle="Agrega una nueva cita para que los usuarios puedan reservarla."
      />
    </section>
  </div>
</template>
<script setup lang="ts">
import Spinner from "../ui/Spinner.vue";
import EmptyState from "../ui/EmptyState.vue";
import type { Appointment } from "../../interfaces";
import AppointmentItem from "./AppointmentItem.vue";
import type { Person } from "../../interfaces/person.interface.ts";

const props = defineProps<{
  loading: boolean;
  appointments: Appointment[];
  appointmentTypes: any[];
  persons: Person[];
}>();

const emit = defineEmits<{
  (e: "updateAppointments"): void;
}>();

const updateAppointments = () => {
  emit("updateAppointments");
};
</script>
