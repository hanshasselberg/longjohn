class Equipment::ReturnsController < ApplicationController
  before_filter :requires_login
  before_filter :requires_studio

  expose(:all_equipment_reservations) { EquipmentReservation.all }
  expose(:equipment_reservation) { EquipmentReservation.find(params[:id]) }
  expose(:returns) { params[:returns].split(',').compact.reject(&:blank?) }
  expose(:models) { Model.all }

  def create
    if all_equipment_reservations.map{ |r| r.returns = returns; r.save }.all?
      redirect_to equipment_returns_path, notice: [ "Thanks!", "See ya soon!"]
    else
      render 'show', id: equipment_reservation._id, alert: [ "Mh", "Didn't work out!"]
    end
  end
end
