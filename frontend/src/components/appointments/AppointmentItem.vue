<template>
  <Card
    ><div class="flex justify-between items-center mb-2">
      <h3 class="font-medium text-gray-900">
        {{ appointment.description }} ({{ appointment.appointment_type.name }})
      </h3>
      <span class="text-gray-600 text-sm">
        {{ new Date(appointment.starts_at).toLocaleString() }}
      </span>
    </div>
    <p class="text-gray-700 text-sm">
      {{ appointment.notes }}
    </p>
  </Card>
</template>
<script setup lang="ts">
import Card from "../ui/Card.vue";
import type { Appointment } from "../../interfaces";

const props = defineProps<{
  appointment: Appointment;
}>();
</script>
