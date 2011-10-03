require 'generate_models'

class Equipment::PickUpsController < ApplicationController
  before_filter :requires_login

  def show
    @reservation = EquipmentReservation.find params[:id]
    @models = GenerateModels.for_pick_up
    Rails.logger.warn @models.to_json.inspect
  end

end
