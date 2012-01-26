class Equipment::PickUpsController < ApplicationController
  before_filter :requires_login

  expose(:equipment_reservation) { EquipmentReservation.find(params[:id]) }
  expose(:pickups) { params[:pickups].split(',').compact.reject(&:blank?) }
  expose(:models) { Model.all }

  def create
    equipment_reservation.pickups = pickups
    if equipment_reservation.save
      redirect_to equipment_pick_ups_path, notice: [ "Great!", "Now do your best."]
    else
      render 'show', id: equipment_reservation._id, alert: [ "Mh", "Didn't work out!"]
    end
  end
end
