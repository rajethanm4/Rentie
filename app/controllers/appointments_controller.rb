class AppointmentsController < ApplicationController
  # before_action :authenticate_account!, only: [:edit, :update, :destroy]
  before_action :set_appointment, only: [:edit, :update, :destroy]
  # before_action :unauthorize_account, only: [:show, :edit, :update, :destroy]

  def index
    if current_account.present?
      @appointments = Appointment.where(account_id: current_account.try(:id))
    elsif current_user.present?
      @appointments = Appointment.where(user_id: current_user.try(:id)) 
    end
  end

  def new
    @appointment = Appointment.new
    @accounts = Account.all
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    if @appointment.save
      redirect_to appointments_path, notice: "Appointment created successfully."
    else
      @accounts = Account.all
      render :new
    end
  end

  def edit
    @accounts = Account.all
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to appointments_path, notice: "Appointment updated successfully."
    else
      @accounts = Account.all
      render :edit
    end
  end

  def show
    @account=Account.find(params[:format])
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: "Appointment deleted successfully."
  end

  # def unauthorize_account(@appointment)
  #   user_appoint_id = @appointment.pluck(:user_id) if current_user.present?
  #   agent_appoint_id = @appointment.pluck(:account_id) if current_account.present?
  #   redirect_to root_path, alert: "Access denied." unless user_appoint_id.include?(current_user.id)  || agent_appoint_id.include?(current_account.id)
  # end

  private

  def set_appointment
    @appointment = Appointment.find_by(id: params[:id])
  if @appointment.nil?
    redirect_to appointments_path, alert: "Appointment not found."
  end
  end

  def appointment_params
    params.require(:appointment).permit(:user_id, :account_id, :date)
  end

end