<template>
  <div class="w-full mb-5">
    <div class="flex items-center justify-between mb-4">
      <button
        @click="previousMonth"
        class="px-3 py-2 rounded-full bg-gray-100 border border-gray-200 text-gray-600 text-sm flex items-center gap-1 cursor-pointer transition-colors ease-in-out duration-300 hover:bg-gray-200"
      >
        <ChevronLeftIcon class="size-5" />
        Anterior
      </button>

      <h2 class="text-lg font-semibold capitalize">
        {{ monthName }} {{ currentYear }}
      </h2>

      <button
        @click="nextMonth"
        class="px-3 py-2 rounded-full bg-gray-100 border border-gray-200 text-gray-600 text-sm flex items-center gap-1 cursor-pointer transition-colors ease-in-out duration-300 hover:bg-gray-200"
      >
        Siguiente
        <ChevronRightIcon class="size-5" />
      </button>
    </div>

    <div
      class="grid grid-cols-7 border-t border-l border-gray-200 rounded-t-lg bg-gray-100"
    >
      <div
        v-for="day in weekDays"
        :key="day"
        class="border-r border-b p-2 text-sm font-semibold text-gray-800 text-center border-gray-200"
      >
        {{ day }}
      </div>
    </div>

    <div
      class="grid grid-cols-7 border-l bg-gray-100 border-gray-200 rounded-lg"
    >
      <div
        v-for="day in calendarDays"
        :key="day.date.toISOString()"
        @click="emit('dayClick', day.date)"
        class="border-r border-b min-h-32 p-2 border-gray-200 rounded-lg cursor-pointer"
        :class="{
          'text-gray-400 bg-gray-50': !day.currentMonth,
        }"
      >
        <span
          class="inline-flex items-center justify-center w-7 h-7 rounded-full text-sm"
          :class="{
            'bg-black text-white': isToday(day.date),
          }"
        >
          {{ day.day }}
        </span>

        <div class="mt-2 flex flex-col gap-1">
          <div
            v-for="appointment in getAppointmentsForDay(day.date)"
            :key="appointment.id"
            class="rounded-lg p-2 text-xs text-gray-800"
            :style="{
              backgroundColor: hexToRgba(
                appointment.appointment_type?.color ?? '#000000',
                0.4,
              ),
            }"
          >
            {{ appointment.description }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref } from "vue";
import { ChevronLeftIcon, ChevronRightIcon } from "@heroicons/vue/24/outline";

import type { Appointment } from "../../interfaces";

const props = defineProps<{
  appointments: Appointment[];
}>();

const emit = defineEmits<{
  dayClick: [date: Date];
}>();

const currentDate = ref(new Date());

const weekDays = ["Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"];

const currentYear = computed(() => {
  return currentDate.value.getFullYear();
});

const currentMonth = computed(() => {
  return currentDate.value.getMonth();
});

const monthName = computed(() => {
  return currentDate.value.toLocaleDateString("es-MX", {
    month: "long",
  });
});

const previousMonth = () => {
  currentDate.value = new Date(currentYear.value, currentMonth.value - 1, 1);
};

const nextMonth = () => {
  currentDate.value = new Date(currentYear.value, currentMonth.value + 1, 1);
};

const calendarDays = computed(() => {
  const year = currentYear.value;
  const month = currentMonth.value;

  const firstDay = new Date(year, month, 1);

  const daysInMonth = new Date(year, month + 1, 0).getDate();

  const firstDayOfWeek = (firstDay.getDay() + 6) % 7;

  const days = [];

  const daysInPreviousMonth = new Date(year, month, 0).getDate();

  for (let i = firstDayOfWeek - 1; i >= 0; i--) {
    const day = daysInPreviousMonth - i;

    days.push({
      day,
      date: new Date(year, month - 1, day),
      currentMonth: false,
    });
  }

  for (let day = 1; day <= daysInMonth; day++) {
    days.push({
      day,
      date: new Date(year, month, day),
      currentMonth: true,
    });
  }

  let nextDay = 1;

  while (days.length % 7 !== 0) {
    days.push({
      day: nextDay,
      date: new Date(year, month + 1, nextDay),
      currentMonth: false,
    });

    nextDay++;
  }

  return days;
});

const getAppointmentsForDay = (date: Date) => {
  return props.appointments.filter((appointment) => {
    const appointmentDate = new Date(appointment.starts_at);

    return (
      appointmentDate.getFullYear() === date.getFullYear() &&
      appointmentDate.getMonth() === date.getMonth() &&
      appointmentDate.getDate() === date.getDate()
    );
  });
};

const isToday = (date: Date) => {
  const today = new Date();

  return (
    date.getDate() === today.getDate() &&
    date.getMonth() === today.getMonth() &&
    date.getFullYear() === today.getFullYear()
  );
};

const hexToRgba = (hex: string, opacity: number) => {
  const cleanHex = hex.replace("#", "");

  const r = parseInt(cleanHex.substring(0, 2), 16);
  const g = parseInt(cleanHex.substring(2, 4), 16);
  const b = parseInt(cleanHex.substring(4, 6), 16);

  return `rgba(${r}, ${g}, ${b}, ${opacity})`;
};
</script>
