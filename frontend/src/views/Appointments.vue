<template>
  <div>
    <PageHeader title="Citas" subtitle="Maneja las citas disponibles">
      <template #actions>
        <div class="hidden md:flex items-center gap-2">
          <button
            v-if="currentView == ViewType.CALENDAR"
            type="button"
            @click="switchView(ViewType.LIST)"
            class="border border-gray-200 rounded-full p-2 bg-white hover:bg-gray-100 transition-colors cursor-pointer"
          >
            <QueueListIcon class="w-5 h-5 text-gray-600" />
          </button>
          <button
            v-else
            type="button"
            @click="switchView(ViewType.CALENDAR)"
            class="border border-gray-200 rounded-full p-2 bg-white hover:bg-gray-100 transition-colors cursor-pointer"
          >
            <CalendarDaysIcon class="w-5 h-5 text-gray-600" />
          </button>
          <Input v-model="search" placeholder="Buscar cita" type="search" />
          <Button type="button" @click="showModal = true">Agregar Cita</Button>
        </div>
      </template>
    </PageHeader>
    <AppointmentList
      v-if="currentView === ViewType.LIST"
      :loading="loading"
      :appointments="appointments"
      :appointmentTypes="appointmentTypes"
      @updateAppointments="getAppointments"
    />
    <Modal
      :show="showModal"
      @close="showModal = false"
      @action="submitForm"
      title="Agregar Cita"
      description="Completa los detalles para agregar una nueva cita"
      actionButtonLabel="Crear cita"
    >
      <div class="flex flex-col md:grid md:grid-cols-2 gap-2">
        <Input
          v-model="form.description"
          label="Descripción"
          placeholder="Ingrese la descripción"
          class="col-span-2"
        />
        <Input
          v-model="form.notes"
          label="Notas"
          placeholder="Ingrese las notas"
          class="col-span-2"
        />
        <Dropdown
          v-model="form.appointment_type_id"
          :options="
            appointmentTypes.map((type) => ({
              value: type.id,
              label: type.name,
            }))
          "
          labelText="Tipo de cita"
          placeholder="Seleccione un tipo de cita"
          class="col-span-2"
        />
        <Input
          v-model="form.starts_at"
          label="Fecha y hora de inicio"
          placeholder="Ingrese la fecha y hora de inicio"
          type="datetime-local"
        />
        <Input
          v-model="form.ends_at"
          label="Fecha y hora de fin"
          placeholder="Ingrese la fecha y hora de fin"
          type="datetime-local"
        />
      </div>
    </Modal>
  </div>
</template>
<script setup lang="ts">
import PageHeader from "../components/PageHeader.vue";
import Input from "../components/ui/Input.vue";
import Button from "../components/ui/Button.vue";

import { ref, onMounted, watch } from "vue";
import type { Appointment, AppointmentType } from "../interfaces";
import {
  CreateAppointment,
  GetAppointments,
  GetAppointmentTypes,
} from "../services/AppointmentService";
import AppointmentList from "../components/appointments/AppointmentList.vue";
import { debounce } from "../composables/useDebounce";
import { ViewType } from "../constants/enums.ts";
import { QueueListIcon, CalendarDaysIcon } from "@heroicons/vue/24/outline";
import Modal from "../components/ui/Modal.vue";
import Dropdown from "../components/ui/Dropdown.vue";

const appointments = ref<Appointment[]>([]);
const appointmentTypes = ref<AppointmentType[]>([]);
const search = ref<string>("");
const loading = ref<boolean>(false);
const currentView = ref<ViewType>(ViewType.LIST);
const showModal = ref<boolean>(false);

const form = ref<Appointment>({
  id: 0,
  description: "",
  notes: "",
  appointment_type_id: 0,
  starts_at: "",
  ends_at: "",
  created_at: "",
  updated_at: "",
});

const loadAppointments = async (searchTerm: string = "") => {
  try {
    loading.value = true;
    const response = await GetAppointments(searchTerm);
    appointments.value = response.data;
  } catch (error) {
    console.error("Error fetching appointments:", error);
  } finally {
    loading.value = false;
  }
};
const getAppointments = async () => {
  loadAppointments();
};

const debouncedSearch = debounce(async (search: string) => {
  loadAppointments(search);
}, 300);

const switchView = (view: ViewType) => {
  currentView.value = view;
};

const getAppointmentTypes = async () => {
  try {
    const response = await GetAppointmentTypes();
    appointmentTypes.value = response.data;
  } catch (error) {
    console.error("Error fetching appointment types:", error);
  }
};

const submitForm = async () => {
  try {
    if (!validateForm()) {
      return;
    }
    await CreateAppointment(form.value);

    showModal.value = false;

    form.value = {
      id: 0,
      description: "",
      notes: "",
      appointment_type_id: 0,
      starts_at: "",
      ends_at: "",
      created_at: "",
      updated_at: "",
    };

    await getAppointments();
  } catch (error) {
    console.error("Error creating appointment:", error);
  }
};

const validateForm = () => {
  if (
    !form.value.description ||
    !form.value.notes ||
    !form.value.appointment_type_id ||
    !form.value.starts_at ||
    !form.value.ends_at
  ) {
    alert("Por favor, complete todos los campos.");
    return false;
  }
  return true;
};

watch(search, async (newSearch) => {
  debouncedSearch(newSearch);
});

onMounted(async () => {
  await getAppointments();
  await getAppointmentTypes();
});
</script>
