<script setup lang="ts">
import Sidebar from "./components/Sidebar.vue";
import MobileHeader from "./components/MobileHeader.vue";
</script>

<template>
  <div class="md:flex md:flex-1 bg-gray-50 min-h-screen w-full">
    <Sidebar class="hidden md:flex" />

    <MobileHeader />

    <main class="md:ml-88 p-4 md:p-0 md:mt-5 md:mr-8 w-full">
      <RouterView />
    </main>
  </div>
</template>
