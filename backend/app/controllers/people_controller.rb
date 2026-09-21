class PeopleController < ApplicationController
before_action :set_person, only: %i[show update destroy]

  def index
    @people = Person.all.order(:name)

    render json: @people
  end

  def show
    render json: @person
  end

    def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
        render json: @appointment,
            include: [:appointment_type, :people],
            status: :created,
            location: @appointment
    else
        render json: @appointment.errors, status: :unprocessable_content
    end
    end

  def update
    if @person.update(person_params)
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_content
    end
  end

  def destroy
    @person.destroy!

    head :no_content
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name)
  end
end
