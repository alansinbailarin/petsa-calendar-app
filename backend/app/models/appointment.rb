class Appointment < ApplicationRecord
  belongs_to :appointment_type

  validates :description, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :appointment_type_id, presence: true

  validate :starts_at_before_ends_at

  private

  def starts_at_before_ends_at
    return if starts_at.blank? || ends_at.blank?

    if starts_at >= ends_at
      errors.add(:ends_at, "must be after starts_at")
    end
  end
end
