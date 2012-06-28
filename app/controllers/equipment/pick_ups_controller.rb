class Equipment::PickUpsController < ApplicationController
  before_filter :requires_login
  before_filter :requires_studio

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

  def delete_remaining
    equipment_reservation.delete_remaining
    if equipment_reservation.save
      render 'show', id: equipment_reservation._id, notice: [ "Cool.", "Not used reservations deleted."]
    else
      render 'show', id: equipment_reservation._id, alert: [ "Aww..", "Couldn't delete."]
    end
  end
end
