# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# anadir color a appointment types
appointment_types = [
    { name: "Arreglo de barba", color: "#FF5733" },
    { name: "Corte de cabello", color: "#33FF57" },
    { name: "Corte de cabello + barba", color: "#3357FF" },
    { name: "Corte de cabello + barba + cejas", color: "#F133FF" },
    { name: "Paquete VIP (corte de cabello + barba + cejas + Facial)", color: "#FF33A1" },
    { name: "Paquete Supremo (corte de cabello + barba + cejas + Facial + Masaje)", color: "#33FFF1" }
]

appointment_types.each do |appointment_type|
  AppointmentType.find_or_create_by!(name: appointment_type[:name], color: appointment_type[:color])
end

appointments = [
  {
    description: "Cliente frecuente - mantener el largo arriba",
    notes: "Degradado medio y acabado natural",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-15 09:00"),
    ends_at: Time.zone.parse("2026-09-15 10:00")
  },
  {
    description: "Perfilado completo de barba",
    notes: "Definir mejillas y cuello",
    appointment_type: "Arreglo de barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-15 11:00"),
    ends_at: Time.zone.parse("2026-09-15 11:45")
  },
  {
    description: "Cambio de look para evento",
    notes: "Degradado bajo, textura arriba",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-15 13:00"),
    ends_at: Time.zone.parse("2026-09-15 14:00")
  },
  {
    description: "Mantenimiento quincenal",
    notes: "Barba corta y bien marcada",
    appointment_type: "Corte de cabello + barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-16 10:30"),
    ends_at: Time.zone.parse("2026-09-16 11:30")
  },
  {
    description: "Preparación para sesión de fotos",
    notes: "Degradado alto y diseño de barba",
    appointment_type: "Corte de cabello + barba + cejas",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-16 14:00"),
    ends_at: Time.zone.parse("2026-09-16 15:15")
  },
  {
    description: "Corte ejecutivo",
    notes: "Laterales cortos, acabado con pomada",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-17 09:30"),
    ends_at: Time.zone.parse("2026-09-17 10:30")
  },
  {
    description: "Arreglo antes de una boda",
    notes: "Mantener barba natural pero definida",
    appointment_type: "Arreglo de barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-17 12:00"),
    ends_at: Time.zone.parse("2026-09-17 12:45")
  },
  {
    description: "Servicio completo de mantenimiento",
    notes: "Cejas ligeramente más delgadas",
    appointment_type: "Corte de cabello + barba + cejas",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-17 16:00"),
    ends_at: Time.zone.parse("2026-09-17 17:15")
  },
  {
    description: "Corte después de vacaciones",
    notes: "Reducir bastante el volumen",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-18 09:00"),
    ends_at: Time.zone.parse("2026-09-18 10:00")
  },
  {
    description: "Mantenimiento de barba",
    notes: "No retirar demasiado volumen",
    appointment_type: "Arreglo de barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-18 11:30"),
    ends_at: Time.zone.parse("2026-09-18 12:15")
  },
  {
    description: "Experiencia premium antes del fin de semana",
    notes: "Tomar tiempo adicional para el facial",
    appointment_type: "Paquete VIP (corte de cabello + barba + cejas + Facial)",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-18 14:00"),
    ends_at: Time.zone.parse("2026-09-18 16:00")
  },
  {
    description: "Corte para reunión de trabajo",
    notes: "Estilo clásico y discreto",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-19 09:30"),
    ends_at: Time.zone.parse("2026-09-19 10:30")
  },
  {
    description: "Cambio de estilo completo",
    notes: "Definir contornos y limpiar cejas",
    appointment_type: "Corte de cabello + barba + cejas",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-19 11:30"),
    ends_at: Time.zone.parse("2026-09-19 12:45")
  },
  {
    description: "Sesión de relajación y cuidado personal",
    notes: "Cliente solicitó el paquete completo",
    appointment_type: "Paquete Supremo (corte de cabello + barba + cejas + Facial + Masaje)",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-19 14:00"),
    ends_at: Time.zone.parse("2026-09-19 16:30")
  },
  {
    description: "Corte de mantenimiento semanal",
    notes: "Conservar el mismo estilo de la última visita",
    appointment_type: "Corte de cabello",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-20 10:00"),
    ends_at: Time.zone.parse("2026-09-20 11:00")
  },
  {
    description: "Barba para evento familiar",
    notes: "Perfilado definido",
    appointment_type: "Arreglo de barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-20 12:00"),
    ends_at: Time.zone.parse("2026-09-20 12:45")
  },
  {
    description: "Domingo de cuidado completo",
    notes: "Incluir limpieza facial",
    appointment_type: "Paquete VIP (corte de cabello + barba + cejas + Facial)",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-20 14:00"),
    ends_at: Time.zone.parse("2026-09-20 16:00")
  },
  {
    description: "Regreso al estilo anterior",
    notes: "Degradado medio y textura con tijera",
    appointment_type: "Corte de cabello + barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-21 09:30"),
    ends_at: Time.zone.parse("2026-09-21 10:30")
  },
  {
    description: "Preparación para entrevista",
    notes: "Look profesional y limpio",
    appointment_type: "Corte de cabello + barba",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-22 13:00"),
    ends_at: Time.zone.parse("2026-09-22 14:00")
  },
  {
    description: "Sesión completa de relajación",
    notes: "Sin cambios respecto a la última visita",
    appointment_type: "Paquete Supremo (corte de cabello + barba + cejas + Facial + Masaje)",
    location: "Salon de belleza",
    starts_at: Time.zone.parse("2026-09-23 15:00"),
    ends_at: Time.zone.parse("2026-09-23 17:30")
  }
]

people = [
  "Alan Pacheco",
  "Juan Pérez",
  "María López",
  "Carlos García",
  "Ana Martínez",
  "Luis Hernández",
  "Sofía Rodríguez",
  "Diego Sánchez"
]

people.each do |person_name|
  Person.find_or_create_by!(name: person_name)
end

appointments.each do |appointment|
  appointment_type = AppointmentType.find_by!(
    name: appointment[:appointment_type]
  )

  Appointment.find_or_create_by!(
    description: appointment[:description],
    starts_at: appointment[:starts_at]
  ) do |new_appointment|
    new_appointment.notes = appointment[:notes]
    new_appointment.ends_at = appointment[:ends_at]
    new_appointment.appointment_type = appointment_type
    new_appointment.location = appointment[:location]
  end
end