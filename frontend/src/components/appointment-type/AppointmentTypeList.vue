<template>
  <div v-if="loading">
    <div class="w-full h-screen flex justify-center items-center">
      <Spinner />
    </div>
  </div>
  <div v-else>
    <section
      v-if="appointmentTypes.length > 0"
      class="flex flex-col gap-3 mt-6"
    >
      <AppointmentTypeItem
        v-for="appointment_type in appointmentTypes"
        :key="appointment_type.id"
        :appointment_type="appointment_type"
        @updated="updateAppointmentTypes"
      />
    </section>
    <section v-else class="w-full h-screen flex justify-center items-center">
      <EmptyState
        title="No hay tipos de cita disponibles"
        subtitle="Agrega un nuevo tipo de cita."
      />
    </section>
  </div>
</template>
<script setup lang="ts">
import Spinner from "../ui/Spinner.vue";
import type { AppointmentType } from "../../interfaces";
import EmptyState from "../ui/EmptyState.vue";
import AppointmentTypeItem from "./AppointmentTypeItem.vue";

const props = defineProps<{
  loading: boolean;
  appointmentTypes: AppointmentType[];
}>();

const emit = defineEmits<{
  (e: "updateAppointmentTypes"): void;
}>();

const updateAppointmentTypes = () => {
  emit("updateAppointmentTypes");
};
</script>
