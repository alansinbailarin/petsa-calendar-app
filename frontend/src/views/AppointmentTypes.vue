<template>
  <div>
    <PageHeader
      title="Tipos de Citas"
      subtitle="Maneja los tipos de citas disponibles"
    >
      <template #actions>
        <div class="items-center gap-2">
          <Button
            class="hidden md:block"
            type="button"
            @click="showModal = true"
            >Agregar tipo de cita</Button
          >
        </div>
      </template>
    </PageHeader>

    <AppointmentTypeList
      :appointment-types="appointmentTypes"
      :loading="loading"
      @update-appointment-types="getAppointmentTypes"
    />
    <Modal
      :show="showModal"
      @close="showModal = false"
      @action="submitForm"
      title="Editar tipo de cita"
      description="Completa los detalles para editar el tipo cita"
      actionButtonLabel="Guardar cambios"
    >
      <div class="flex flex-col md:grid md:grid-cols-2 gap-2">
        <Input
          v-model="form.name"
          label="Title"
          placeholder="Ingrese el titulo"
          class="col-span-2"
        />
        <div>
          <label
            for="color"
            class="block text-sm font-medium text-gray-700 mb-1"
          >
            Color
          </label>
          <input id="color" type="color" v-model="form.color" />
        </div>
      </div>
    </Modal>
    <div class="fixed bottom-3 right-3">
      <Button class="block md:hidden" type="button" @click="showModal = true"
        >Agregar tipo de cita</Button
      >
    </div>
  </div>
</template>
<script setup lang="ts">
import { onMounted, ref } from "vue";
import PageHeader from "../components/PageHeader.vue";
import Button from "../components/ui/Button.vue";
import type { AppointmentType } from "../interfaces/appointment.interface.ts";
import {
  CreateAppointmentType,
  GetAppointmentTypes,
} from "../services/AppointmentService.ts";
import AppointmentTypeList from "../components/appointment-type/AppointmentTypeList.vue";
import Modal from "../components/ui/Modal.vue";
import Input from "../components/ui/Input.vue";

const showModal = ref<boolean>(false);
const appointmentTypes = ref<AppointmentType[]>([]);
const loading = ref<boolean>(false);

const form = ref<AppointmentType>({
  id: 0,
  name: "",
  color: "",
  created_at: "",
  updated_at: "",
});

const getAppointmentTypes = async () => {
  loading.value = true;
  try {
    const response = await GetAppointmentTypes();
    appointmentTypes.value = response.data;
  } catch (error) {
    console.error("Error fetching appointment types:", error);
  } finally {
    loading.value = false;
  }
};

const submitForm = async () => {
  try {
    if (!validateForm()) {
      return;
    }

    await CreateAppointmentType(form.value);

    showModal.value = false;

    await resetForm();
    await getAppointmentTypes();
  } catch (error) {
    console.error("Error updating appointment:", error);
  }
};

const validateForm = () => {
  if (!form.value.name) {
    alert("Por favor, complete todos los campos.");
    return false;
  }
  return true;
};

const resetForm = async () => {
  form.value = {
    id: 0,
    name: "",
    color: "",
    created_at: "",
    updated_at: "",
  };
};

onMounted(async () => {
  await getAppointmentTypes();
});
</script>
