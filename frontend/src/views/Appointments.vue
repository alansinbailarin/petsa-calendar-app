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
      :persons="persons"
    />
    <MonthView
      v-else
      class="mt-6"
      :appointments="calendarAppointments"
      @dayClick="getAppointmentsByDay"
    />
    <Modal
      :show="showModal"
      @close="closeModal"
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
          v-model="form.location"
          label="Ubicación"
          placeholder="Ingrese la ubicación"
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
      <span class="block text-sm font-medium text-gray-700 mb-1 mt-3">
        Personas interesadas
      </span>
      <div class="overflow-y-auto h-36 grid grid-cols-2 mt-4">
        <div v-for="person in persons" class="flex items-center gap-2">
          <input
            type="checkbox"
            :id="`person-${person.id}`"
            :name="`person-${person.id}`"
            :value="person.id"
            class="bg-gray-900"
            @change="selectPerson(person)"
          />
          <label :for="`person-${person.id}`">{{ person.name }}</label>
        </div>
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
import type { Person } from "../interfaces/person.interface.ts";
import { GetPersons } from "../services/PersonService.ts";
import MonthView from "../components/ui/MonthView.vue";

const appointments = ref<Appointment[]>([]);
const calendarAppointments = ref<Appointment[]>([]);
const appointmentTypes = ref<AppointmentType[]>([]);
const search = ref<string>("");
const loading = ref<boolean>(false);
const currentView = ref<ViewType>(ViewType.LIST);
const showModal = ref<boolean>(false);
const persons = ref<Person[]>([]);
const selectedDate = ref<string>("");

const form = ref<Appointment>({
  id: 0,
  description: "",
  notes: "",
  appointment_type_id: 0,
  location: "",
  people: [],
  starts_at: "",
  ends_at: "",
  created_at: "",
  updated_at: "",
});

const loadAppointments = async (searchTerm: string = "", date: string = "") => {
  try {
    loading.value = true;
    const response = await GetAppointments(searchTerm, date);
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
  currentView.value = ViewType.LIST;

  const response = await GetAppointments(search, selectedDate.value);

  appointments.value = response.data;
}, 300);

const switchView = async (view: ViewType) => {
  currentView.value = view;

  if (view === ViewType.LIST) {
    selectedDate.value = "";
    await getAppointments();
  }
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

    await resetForm();

    await getAppointments();
  } catch (error) {
    console.error("Error creating appointment:", error);
  }
};

const getPersons = async (searchTerm: string = "") => {
  try {
    const response = await GetPersons(searchTerm);
    persons.value = response.data;
  } catch (error) {
    console.error("Error fetching persons:", error);
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

const selectPerson = (person: Person) => {
  const people = form.value.people ?? [];

  const index = people.findIndex((p) => p.id === person.id);

  if (index === -1) {
    people.push(person);
  } else {
    people.splice(index, 1);
  }

  form.value.people = people;
};

const resetForm = async () => {
  form.value = {
    id: 0,
    description: "",
    notes: "",
    appointment_type_id: 0,
    location: "",
    people: [],
    starts_at: "",
    ends_at: "",
    created_at: "",
    updated_at: "",
  };
};

const closeModal = async () => {
  showModal.value = false;

  await resetForm();
};

const getCalendarAppointments = async () => {
  try {
    const response = await GetAppointments("*");
    calendarAppointments.value = response.data;
  } catch (error) {
    console.error("Error fetching calendar appointments:", error);
  }
};

const formatDate = (date: Date) => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
};

const getAppointmentsByDay = async (date: Date) => {
  const dateString = formatDate(date);

  const response = await GetAppointments("", dateString);

  appointments.value = response.data;

  selectedDate.value = "";

  currentView.value = ViewType.LIST;
};

watch(search, async (newSearch) => {
  debouncedSearch(newSearch);
});

onMounted(async () => {
  await getAppointments();
  await getAppointmentTypes();
  await getPersons();
  await getCalendarAppointments();
});
</script>
