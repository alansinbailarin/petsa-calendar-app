class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[show update destroy]

  # GET /appointments
  def index
    @appointments = Appointment
      .includes(:appointment_type, :people)

    if params[:date].present?
      date = Date.parse(params[:date])

      @appointments = @appointments.where(
        starts_at: date.beginning_of_day..date.end_of_day
      )
    end

    if params[:search].present? && params[:search] != "*"
      @appointments = @appointments.where(
        "description LIKE :search OR notes LIKE :search",
        search: "%#{params[:search]}%"
      )
    end

    if params[:date].blank? && params[:search].blank?
      @appointments = @appointments.where(
        "starts_at >= ?",
        Time.current
      )
    end

    @appointments = @appointments.order(:starts_at)

    render json: @appointments, include: [:appointment_type, :people]
  end

  # GET /appointments/1
  def show
    render json: @appointment, include: [:appointment_type, :people]
  end

  # POST /appointments
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

  # PATCH/PUT /appointments/1
  def update
    if @appointment.update(appointment_params)
      render json: @appointment, include: [:appointment_type, :people]
    else
      render json: @appointment.errors, status: :unprocessable_content
    end
  end

  # DELETE /appointments/1
  def destroy
    @appointment.destroy!
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    permitted = params.permit(
      :description,
      :notes,
      :appointment_type_id,
      :starts_at,
      :ends_at,
      :location,
      people: [:id]
    )

    people = permitted.delete(:people) || []

    person_ids = people
      .map { |person| person[:id] || person["id"] }
      .compact

    permitted[:person_ids] = person_ids

    permitted[:starts_at] =
      Time.zone.parse(permitted[:starts_at]) if permitted[:starts_at].present?

    permitted[:ends_at] =
      Time.zone.parse(permitted[:ends_at]) if permitted[:ends_at].present?

    permitted
  end
end