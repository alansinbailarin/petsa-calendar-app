<template>
  <div>
    <label class="block text-sm font-medium text-gray-700 mb-1" v-if="label">
      {{ label }}
    </label>
    <input
      :type="type"
      :placeholder="placeholder"
      :value="modelValue"
      @input="
        $emit('update:modelValue', ($event.target as HTMLInputElement).value)
      "
      class="border w-full bg-white border-gray-200 rounded-full px-4 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-gray-500 focus:border-gray-500"
    />
  </div>
</template>

<script setup lang="ts">
defineProps<{
  type?: string;
  placeholder?: string;
  modelValue: string;
  label?: string;
}>();
</script>
