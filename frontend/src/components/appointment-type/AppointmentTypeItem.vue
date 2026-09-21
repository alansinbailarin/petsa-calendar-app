<template>
  <Card
    class="cursor-pointer flex items-center justify-between"
    @click="openModal"
    :color="appointment_type?.color || 'gray'"
  >
    <h3>{{ appointment_type.name }}</h3>
    <button
      type="button"
      class="bg-red-50 rounded-full border border-red-200 text-sm text-red-400 px-4 py-1.5 cursor-pointer hover:bg-red-100 transition-colors ease-in-out duration-300"
      @click.stop="deleteAppointmentType(appointment_type.id)"
    >
      Eliminar
    </button>
  </Card>
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
        <label for="color" class="block text-sm font-medium text-gray-700 mb-1">
          Color
        </label>
        <input id="color" type="color" v-model="form.color" />
      </div>
    </div>
  </Modal>
</template>
<script setup lang="ts">
import { ref } from "vue";
import type { AppointmentType } from "../../interfaces/appointment.interface.ts";
import Card from "../ui/Card.vue";
import Modal from "../ui/Modal.vue";
import Input from "../ui/Input.vue";
import {
  DeleteAppointmentType,
  UpdateAppointmentType,
} from "../../services/AppointmentService.ts";

const props = defineProps<{
  appointment_type: AppointmentType;
}>();

const emit = defineEmits<{
  updated: [];
}>();

const showModal = ref<boolean>(false);

const form = ref<AppointmentType>({
  id: 0,
  name: "",
  color: "",
  created_at: "",
  updated_at: "",
});

const openModal = () => {
  form.value = {
    id: props.appointment_type.id,
    name: props.appointment_type.name,
    color: props.appointment_type.color,
    created_at: props.appointment_type.created_at,
    updated_at: props.appointment_type.updated_at,
  };

  showModal.value = true;
};

const submitForm = async () => {
  try {
    if (!validateForm()) {
      return;
    }

    const appointmentTypeToUpdate = {
      ...form.value,
    };

    await UpdateAppointmentType(appointmentTypeToUpdate);

    showModal.value = false;

    emit("updated");
  } catch (error) {
    console.error("Error updating appointment:", error);
  }
};

const deleteAppointmentType = async (appointmentTypeId: number) => {
  try {
    if (!confirm("¿Estás seguro de que deseas eliminar este registro?")) {
      return;
    }

    await DeleteAppointmentType(appointmentTypeId);

    emit("updated");
  } catch (error) {
    console.error("Error deleting appointment type:", error);
    alert(
      "No se puede eliminar este tipo de cita porque tiene citas asociadas.",
    );
  }
};

const validateForm = () => {
  if (!form.value.name) {
    alert("Por favor, complete todos los campos.");
    return false;
  }
  return true;
};
</script>
