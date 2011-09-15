require_dependency 'generate_models'

class Equipment::ReservationsController < ApplicationController
  before_filter :requires_login

  def new
    @models = GenerateModels.process Device.all
  end

  def create
    if EquipmentReservation.create params[:reservation].merge({user: current_user._id})
      redirect_to equipment_reservations_path, notice: [
        "Reserved!", "This Reservation was successfully created."]
    else
      render 'new', notice: [ "Oops!", "Something went wrong."]
    end
  end

  def show
    @reservation = EquipmentReservation.find params[:id]
    Rails.logger.warn @reservation.inspect
  end

  def destroy
    if EquipmentReservation.find(params[:id]).destroy
      redirect_to equipment_reservations_path, notice: [
        "Destroyed!", "This Reservation was successfully destroyed."]
    end
  end

end
