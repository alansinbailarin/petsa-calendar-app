<template>
  <div
    class="bg-white border border-gray-200 rounded-lg p-4"
    :style="{
      borderLeftWidth: '4px',
      borderLeftColor: color,
    }"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  color: string;
}>();
</script>
