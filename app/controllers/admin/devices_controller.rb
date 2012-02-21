class Admin::DevicesController < ApplicationController
  before_filter :requires_admin

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

  def destroy
    if device.destroy
      redirect_to admin_devices_path, notice: [
        "Destroyed!", "This Device was successfully destroyed."]
    end
  end
end
