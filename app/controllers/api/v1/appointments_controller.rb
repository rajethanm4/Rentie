class Api::V1::AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_appointment, only: [:show, :update, :destroy]

  def index
    @appointments = Appointment.all
    render json: {appointment: @appointments}
  end

  def show
    if @appointment
      render json: {appointment: @appointment}
    else
      render json: {error: 'Appointment not found'}, status: :not_found
    end
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      render json: @appointment, status: :created
    else
      render json: {error: @appointment.errors.full_messages.join(', ')}, status: :unprocessable_entity
    end
  end

  def update
    if @appointment
      if @appointment.update(appointment_params)
        render json: @appointment
      else
        render json: {error: @appointment.errors.full_messages.join(', ')}, status: :unprocessable_entity
      end
    else
      render json: {error: 'Appointment not found'}, status: :not_found
    end
  end

  def destroy
    if @appointment
      @appointment.destroy
    else
      render json: {error: 'Appointment not found'}, status: :not_found
    end
  end

  private

  def set_appointment
    @appointment = Appointment.find_by(id: params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :account_id, :date)
  end

end