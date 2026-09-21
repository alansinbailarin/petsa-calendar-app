<template>
  <div v-if="show" class="">
    <div class="fixed inset-0 bg-gray-900 opacity-40" @click="closeModal"></div>

    <div class="fixed inset-0 flex items-center justify-center">
      <div
        class="bg-white md:w-1/3 w-full m-4 md:m-0 text-black rounded-3xl p-5"
      >
        <h3 class="text-gray-900 font-semibold">{{ title }}</h3>
        <p class="text-gray-600 text-sm mb-4">{{ description }}</p>
        <slot></slot>

        <div class="flex justify-end gap-2 mt-4">
          <button
            type="button"
            @click="closeModal"
            class="border border-gray-200 rounded-full p-2 bg-white hover:bg-gray-100 transition-colors cursor-pointer"
          >
            Cancelar
          </button>
          <Button type="button" @click="actionModal">{{
            actionButtonLabel || "Aceptar"
          }}</Button>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import Button from "./Button.vue";

defineProps<{
  title: string;
  description: string;
  show: boolean;
  actionButtonLabel?: string;
}>();

const emit = defineEmits<{
  (e: "close"): void;
  (e: "action"): void;
}>();

const closeModal = () => {
  emit("close");
};

const actionModal = () => {
  emit("action");
};
</script>
