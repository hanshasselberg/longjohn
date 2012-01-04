require 'generate_models'

class Equipment::PickUpsController < ApplicationController
  before_filter :requires_login

  expose(:equipment_reservation)
  expose(:models) { GenerateModels.for_pick_up }

  def show
  end

end
