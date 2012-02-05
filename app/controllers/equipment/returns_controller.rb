class Equipment::ReturnsController < ApplicationController
  before_filter :requires_login

  expose(:equipment_reservation) { EquipmentReservation.find(params[:id]) }
  expose(:returns) { params[:returns].split(',').compact.reject(&:blank?) }
  expose(:models) { Model.all }

  def create
    equipment_reservation.returns = returns
    if equipment_reservation.save
      redirect_to equipment_returns_path, notice: [ "Thanks!", "See ya soon!"]
    else
      render 'show', id: equipment_reservation._id, alert: [ "Mh", "Didn't work out!"]
    end
  end
end
