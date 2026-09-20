<script setup lang="ts">
import Sidebar from "./components/Sidebar.vue";
</script>

<template>
  <div class="flex flex-1 bg-gray-50 h-screen w-full">
    <Sidebar />
    <main class="ml-88 mt-5 mr-8 w-full">
      <RouterView></RouterView>
    </main>
  </div>
</template>
