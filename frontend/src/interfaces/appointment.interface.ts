import type { Person } from "./person.interface";

export interface Appointment {
  id: number;
  description: string;
  notes: string;
  appointment_type_id: number;
  appointment_type?: AppointmentType;
  location: string;
  people?: Person[];
  starts_at: string;
  ends_at: string;
  created_at?: string;
  updated_at?: string;
}

export interface AppointmentType {
  id: number;
  name: string;
  color: string;
  created_at: string;
  updated_at: string;
}
