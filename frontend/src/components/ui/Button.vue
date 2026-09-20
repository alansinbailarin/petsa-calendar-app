<template>
  <button
    :type="type"
    class="bg-gray-900 rounded-full px-6 py-2 text-white cursor-pointer text-sm hover:bg-gray-800 transition-colors duration-300"
  >
    <slot></slot>
  </button>
</template>
<script setup lang="ts">
defineProps<{
  type?: "button" | "submit" | "reset";
}>();
</script>
