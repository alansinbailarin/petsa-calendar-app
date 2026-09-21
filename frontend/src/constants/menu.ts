import { TagIcon } from "@heroicons/vue/24/outline";
import CalendarDaysIcon from "@heroicons/vue/24/solid/esm/CalendarDaysIcon";

export const MENU_ITEMS = [
  {
    name: "Appointments",
    icon: CalendarDaysIcon,
    route: "/",
  },
  {
    name: "Appointment Types",
    icon: TagIcon,
    route: "/appointment-types",
  },
];
