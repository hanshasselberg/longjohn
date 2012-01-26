class Equipment::PickUpsController < ApplicationController
  before_filter :requires_login

  expose(:equipment_reservation)
  expose(:models) { Model.all }
end
