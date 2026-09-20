<template>
  <input
    :type="type"
    :placeholder="placeholder"
    :value="modelValue"
    @input="
      $emit('update:modelValue', ($event.target as HTMLInputElement).value)
    "
    class="border bg-white border-gray-300 rounded-full px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-gray-500"
  />
</template>

<script setup lang="ts">
defineProps<{
  type?: string;
  placeholder?: string;
  modelValue: string;
}>();
</script>
