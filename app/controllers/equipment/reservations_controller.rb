class Equipment::ReservationsController < ApplicationController
  before_filter :requires_login

  def index
  end

  def create
  end

  def create
    redirect_to equipment_reservations_path, :notice => ["Reserved!", "This Reservation was successfully created."]
  end

end
