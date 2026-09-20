import type { Appointment } from "../interfaces";
import api from "./api";

export const GetAppointments = (searchTerm?: string) => {
  const searchParam = searchTerm
    ? `?search=${encodeURIComponent(searchTerm)}`
    : "";
  return api.get<Appointment[]>(`/appointments${searchParam}`);
};
