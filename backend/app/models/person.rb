class Person < ApplicationRecord
    has_many :appointment_people, dependent: :destroy
  has_many :appointments, through: :appointment_people
end
