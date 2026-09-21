class CreateAppointmentPeople < ActiveRecord::Migration[7.2]
  def change
    create_table :appointment_people do |t|
      t.references :appointment, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
