<script setup lang="ts">
import { ref } from "vue";
import { RouterLink, useRoute } from "vue-router";
import { Bars3Icon, XMarkIcon } from "@heroicons/vue/24/outline";

import { MENU_ITEMS as menu } from "../constants/menu";

const route = useRoute();

const isOpen = ref(false);

const closeMenu = () => {
  isOpen.value = false;
};
</script>

<template>
  <header class="md:hidden bg-white border-b border-gray-200">
    <div class="flex items-center justify-between px-4 py-3">
      <button
        type="button"
        class="p-2 rounded-lg hover:bg-gray-100 transition-colors"
        @click="isOpen = !isOpen"
      >
        <XMarkIcon v-if="isOpen" class="size-5" />
        <Bars3Icon v-else class="size-5" />
      </button>
    </div>

    <div v-if="isOpen" class="border-t border-gray-100 px-4 py-3">
      <nav class="flex flex-col gap-1">
        <RouterLink
          v-for="item in menu"
          :key="item.name"
          :to="item.route"
          class="flex items-center gap-3 p-2 rounded-lg hover:bg-gray-100 transition-colors"
          :class="{
            'bg-gray-100': route.path === item.route,
          }"
          @click="closeMenu"
        >
          <component :is="item.icon" class="w-5 h-5 text-gray-600" />

          <span class="text-gray-800 text-sm">
            {{ item.name }}
          </span>
        </RouterLink>
      </nav>
    </div>
  </header>
</template>
