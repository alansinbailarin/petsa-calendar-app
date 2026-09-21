import type { Appointment, AppointmentType } from "../interfaces";
import api from "./api";

export const GetAppointments = (searchTerm?: string) => {
  const searchParam = searchTerm
    ? `?search=${encodeURIComponent(searchTerm)}`
    : "";
  return api.get<Appointment[]>(`/appointments${searchParam}`);
};

export const GetAppointmentTypes = () => {
  return api.get<AppointmentType[]>(`/appointment_types`);
};

export const CreateAppointment = (appointment: Appointment) => {
  return api.post<Appointment>(`/appointments`, appointment);
};

export const UpdateAppointment = (appointment: Appointment) => {
  return api.put<Appointment>(`/appointments/${appointment.id}`, appointment);
};
