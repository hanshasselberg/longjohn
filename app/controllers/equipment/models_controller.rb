require_dependency 'generate_models'

class Equipment::ModelsController < ApplicationController
  before_filter :requires_login

  def index
    @models = GenerateModels.process Device.all
    respond_to do |format|
      format.js { render json: @models }
    end
  end

end
