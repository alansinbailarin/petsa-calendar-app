<template>
  <div>
    <PageHeader title="Citas" subtitle="Maneja las citas disponibles">
      <template #actions>
        <div class="flex items-center gap-2">
          <button>{{ currentView }}</button>
          <Input v-model="search" placeholder="Buscar cita" type="search" />
          <Button type="button">Agregar Cita</Button>
        </div>
      </template>
    </PageHeader>
    <AppointmentList
      v-if="currentView === 'list'"
      :loading="loading"
      :appointments="appointments"
    />
  </div>
</template>
<script setup lang="ts">
import PageHeader from "../components/PageHeader.vue";
import Input from "../components/ui/Input.vue";
import Button from "../components/ui/Button.vue";

import { ref, onMounted, watch } from "vue";
import type { Appointment } from "../interfaces";
import { GetAppointments } from "../services/AppointmentService";
import AppointmentList from "../components/appointments/AppointmentList.vue";
import { debounce } from "../composables/useDebounce";

const appointments = ref<Appointment[]>([]);
const search = ref<string>("");
const loading = ref<boolean>(false);
const currentView = ref<string>("list"); // 'list' or 'calendar'

const getAppointments = async () => {
  try {
    loading.value = true;
    const response = await GetAppointments();

    appointments.value = response.data;
  } catch (error) {
    console.error("Error fetching appointments:", error);
  } finally {
    loading.value = false;
  }
};

const debouncedSearch = debounce(async (search: string) => {
  try {
    loading.value = true;
    const response = await GetAppointments(search);
    appointments.value = response.data;
  } catch (error) {
    console.error("Error fetching appointments:", error);
  } finally {
    loading.value = false;
  }
}, 300);

watch(search, async (newSearch) => {
  debouncedSearch(newSearch);
});

onMounted(async () => {
  await getAppointments();
});
</script>
