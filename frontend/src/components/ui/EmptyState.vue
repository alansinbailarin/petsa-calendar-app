<template>
  <div class="text-center">
    <h3 class="font-medium text-gray-900">{{ title }}</h3>
    <p class="text-gray-600 text-sm">{{ subtitle }}</p>
  </div>
</template>
<script setup lang="ts">
defineProps<{
  title: string;
  subtitle: string;
}>();
</script>
