class Admin::DevicesController < ApplicationController
  before_filter :requires_login

  expose(:devices) { Device.all.asc(:kind, :company, :model, :barcode) }
  expose(:device)

  def update
    if device.save
      redirect_to admin_devices_path, :notice => ["Changed!", "You really changes that device!"]
    else
      flash.now.alert = ["Ooops!", "Something went wrong."]
      render "edit"
    end
  end
end
