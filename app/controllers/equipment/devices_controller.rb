class Equipment::DevicesController < ApplicationController
  before_filter :requires_login

  def index
    @devices = Device.all
    respond_to do |format|
      format.js { render json: @devices }
    end
  end

end
