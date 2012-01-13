class Equipment::ReservationsController < ApplicationController
  before_filter :requires_login

  expose(:equipment_reservation)
  # expose(:models) { GenerateModels.for_reservation equipment_reservation.from, equipment_reservation.to }
  expose(:models) { Model.in equipment_reservation.from, equipment_reservation.to}

  def new
    Rails.logger.warn "Models:"
    Rails.logger.warn models.inspect
  end

  def create
    if equipment_reservation.save
      redirect_to equipment_reservations_path, notice: [
        "Reserved!", "This Reservation was successfully created."]
    else
      render 'new', notice: [ "Oops!", "Something went wrong."]
    end
  end

  def destroy
    if equipment_reservation.destroy
      redirect_to equipment_reservations_path, notice: [
        "Destroyed!", "This Reservation was successfully destroyed."]
    end
  end

end
