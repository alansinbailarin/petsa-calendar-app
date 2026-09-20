<template>
  <div class="w-full">
    <div class="flex items-center justify-between">
      <h1 class="text-xl font-bold text-gray-800">{{ props.title }}</h1>
      <slot name="actions"></slot>
    </div>
    <p class="text-gray-600">{{ props.subtitle }}</p>
  </div>
</template>
<script setup lang="ts">
const props = defineProps<{
  title: string;
  subtitle?: string;
}>();
</script>
