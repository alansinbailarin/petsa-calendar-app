import type { Appointment, AppointmentType } from "../interfaces";
import api from "./api";

export const GetAppointments = (searchTerm?: string, date?: string) => {
  const params = new URLSearchParams();

  if (searchTerm) {
    params.append("search", searchTerm);
  }

  if (date) {
    params.append("date", date);
  }

  const queryString = params.toString();

  return api.get<Appointment[]>(
    `/appointments${queryString ? `?${queryString}` : ""}`,
  );
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

export const CreateAppointmentType = (appointmentType: AppointmentType) => {
  return api.post<AppointmentType>(`/appointment_types`, appointmentType);
};

export const UpdateAppointmentType = (appointmentType: AppointmentType) => {
  return api.put<AppointmentType>(
    `/appointment_types/${appointmentType.id}`,
    appointmentType,
  );
};
