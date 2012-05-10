class Admin::UsersController < ApplicationController
  before_filter :requires_admin

  expose(:users) { User.all }
  expose(:user)

  def update
    if user.save
      redirect_to admin_users_path, :notice => ["Changed!", "You really changed that user!"]
    else
      flash.now.alert = ["Ooops!", "Something went wrong."]
      render "edit"
    end
  end

  def destroy
    if user.destroy
      redirect_to admin_users_path, :notice => ["Deleted!", "You really deleted that user!"]
    else
      flash.now.alert = ["Ooops!", "Something went wrong."]
      render "index"
    end
  end
end
