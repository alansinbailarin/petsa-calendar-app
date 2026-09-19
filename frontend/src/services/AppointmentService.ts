import type { Appointment } from "../interfaces";
import api from "./api";

export const GetAppointments = () => {
  return api.get<Appointment[]>("/appointments");
};
