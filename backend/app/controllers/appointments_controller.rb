class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show update destroy ]

  # GET /appointments
  def index
    if params[:search].present?
      @appointments = Appointment.includes(:appointment_type).where("description LIKE :search OR notes LIKE :search", search: "%#{params[:search]}%").order(:starts_at)
    else
      @appointments = Appointment.includes(:appointment_type).where("starts_at >= ?", Time.current).order(:starts_at)
    end

    render json: @appointments, include: :appointment_type
  end

  # GET /appointments/1
  def show
    render json: @appointment
  end

  # POST /appointments
  def create
    @appointment = Appointment.new(appointment_params)

    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_content
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy!
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def appointment_params
    params.require(:appointment).permit(:description, :notes, :appointment_type_id, :starts_at, :ends_at)
  end
end
