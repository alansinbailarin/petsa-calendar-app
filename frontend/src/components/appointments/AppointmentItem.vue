```vue
<template>
  <Card @click="openModal">
    <div class="flex justify-between items-center mb-2">
      <h3 class="font-medium text-gray-900">
        {{ appointment.description }}
        ({{ appointment.appointment_type?.name }})
      </h3>

      <span class="text-gray-600 text-sm hidden md:inline-block">
        {{ new Date(appointment.starts_at).toLocaleString() }}
      </span>
    </div>

    <p class="text-gray-700 text-sm">
      {{ appointment.notes }}
    </p>

    <span class="text-gray-600 text-sm md:hidden block">
      {{ new Date(appointment.starts_at).toLocaleString() }}
    </span>
  </Card>

  <Modal
    :show="showModal"
    @close="showModal = false"
    @action="submitForm"
    title="Editar Cita"
    description="Completa los detalles para editar la cita"
    actionButtonLabel="Guardar cambios"
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
        type="datetime-local"
      />

      <Input
        v-model="form.ends_at"
        label="Fecha y hora de fin"
        type="datetime-local"
      />
    </div>
  </Modal>
</template>

<script setup lang="ts">
import { ref } from "vue";

import Card from "../ui/Card.vue";
import Input from "../ui/Input.vue";
import Modal from "../ui/Modal.vue";
import Dropdown from "../ui/Dropdown.vue";

import type { Appointment, AppointmentType } from "../../interfaces";
import { UpdateAppointment } from "../../services/AppointmentService.ts";

const props = defineProps<{
  appointment: Appointment;
  appointmentTypes: AppointmentType[];
}>();

const emit = defineEmits<{
  updated: [];
}>();

const showModal = ref(false);

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

const formatForDateTimeLocal = (date: string) => {
  const value = new Date(date);

  const year = value.getFullYear();
  const month = String(value.getMonth() + 1).padStart(2, "0");
  const day = String(value.getDate()).padStart(2, "0");
  const hours = String(value.getHours()).padStart(2, "0");
  const minutes = String(value.getMinutes()).padStart(2, "0");

  return `${year}-${month}-${day}T${hours}:${minutes}`;
};

const formatForApi = (date: string) => {
  return new Date(date).toISOString();
};

const openModal = () => {
  form.value = {
    id: props.appointment.id,
    description: props.appointment.description,
    notes: props.appointment.notes,
    appointment_type_id: props.appointment.appointment_type_id,

    starts_at: formatForDateTimeLocal(props.appointment.starts_at),
    ends_at: formatForDateTimeLocal(props.appointment.ends_at),

    created_at: props.appointment.created_at,
    updated_at: props.appointment.updated_at,
  };

  showModal.value = true;
};

const submitForm = async () => {
  try {
    if (!validateForm()) {
      return;
    }

    const appointmentToUpdate = {
      ...form.value,
      starts_at: formatForApi(form.value.starts_at),
      ends_at: formatForApi(form.value.ends_at),
    };

    await UpdateAppointment(appointmentToUpdate);

    showModal.value = false;

    emit("updated");
  } catch (error) {
    console.error("Error updating appointment:", error);
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
</script>
