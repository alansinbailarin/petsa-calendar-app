<template>
  <div class="relative">
    <label
      v-if="labelText"
      class="block text-sm font-medium text-gray-700 mb-1"
    >
      {{ labelText }}
    </label>

    <button
      type="button"
      @click="isOpen = !isOpen"
      class="border w-full bg-white border-gray-200 rounded-full px-4 py-2 text-sm text-left flex items-center justify-between line-clamp-1"
    >
      <span>
        {{ selectedOption?.label ?? props.placeholder }}
      </span>

      <ChevronDownIcon
        class="w-4 h-4 inline-block ml-2 text-gray-400 transition-all ease-in-out duration-300"
        :class="isOpen ? 'rotate-180' : ''"
      />
    </button>

    <div
      v-if="isOpen"
      class="absolute z-10 mt-2 w-full bg-white border border-gray-200 rounded-xl flex flex-col divide-y divide-gray-200 shadow-lg overflow-hidden"
    >
      <button
        v-for="option in options"
        :key="option.value"
        type="button"
        @click="selectOption(option)"
        class="hover:bg-gray-100 transition-colors ease-in-out duration-300 cursor-pointer text-left px-4 py-2"
      >
        {{ option.label }}
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { ChevronDownIcon } from "@heroicons/vue/24/outline";

interface DropdownOption {
  value: string | number;
  label: string;
}

const props = withDefaults(
  defineProps<{
    modelValue: string | number;
    options: DropdownOption[];
    placeholder?: string;
    labelText?: string;
  }>(),
  {
    placeholder: "Selecciona una opción",
  },
);

const emit = defineEmits<{
  "update:modelValue": [value: string | number];
}>();

const isOpen = ref(false);

const selectedOption = computed(() =>
  props.options.find((option) => option.value === props.modelValue),
);

const selectOption = (option: DropdownOption) => {
  emit("update:modelValue", option.value);
  isOpen.value = false;
};
</script>
