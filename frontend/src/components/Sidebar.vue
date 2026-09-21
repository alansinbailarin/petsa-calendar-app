<template>
  <div
    class="bg-white fixed left-5 top-5 bottom-5 p-4 rounded-xl w-72 border border-gray-200 overflow-y-auto"
  >
    <div class="flex flex-col gap-3 w-full">
      <RouterLink
        v-for="item in menu"
        :key="item.name"
        :to="item.route"
        class="flex items-center gap-3 p-2 rounded-lg hover:bg-gray-100 cursor-pointer transition-colors"
        :class="{
          'bg-gray-100': route.path === item.route,
        }"
      >
        <component :is="item.icon" class="w-5 h-5 text-gray-600" />
        <span class="text-gray-800 text-sm">{{ item.name }}</span>
      </RouterLink>
    </div>
  </div>
</template>
<script setup lang="ts">
import { MENU_ITEMS as menu } from "../constants/menu";
import { useRoute, RouterLink } from "vue-router";

const route = useRoute();
</script>
