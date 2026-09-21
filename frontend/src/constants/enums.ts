export const ViewType = {
  LIST: "list",
  CALENDAR: "calendar",
} as const;

export type ViewType = (typeof ViewType)[keyof typeof ViewType];
