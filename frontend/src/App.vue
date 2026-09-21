<script setup lang="ts">
import Sidebar from "./components/Sidebar.vue";
</script>

<template>
  <div class="md:flex md:flex-1 bg-gray-50 h-screen w-full p-4 md:p-0">
    <Sidebar class="hidden md:flex" />
    <main class="md:ml-88 mt-5 mr-8 w-full">
      <RouterView></RouterView>
    </main>
  </div>
</template>
