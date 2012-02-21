class Admin::UsersController < ApplicationController
  before_filter :requires_admin

  expose(:users) { User.all }
  expose(:user)

  def update
    if user.save
      redirect_to admin_users_path, :notice => ["Changed!", "You really changes that user!"]
    else
      flash.now.alert = ["Ooops!", "Something went wrong."]
      render "edit"
    end
  end
end
