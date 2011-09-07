class SessionsController < ApplicationController
  def new
  end

  def create
    user = User
      .authenticate(params[:user][:email], params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => ["Logged in!", "Welcome #{user.email}"]
    else
      flash.now.alert = ["Opps!", "Invalid email or password"]
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to log_in_path, :notice => ["Logged out!", "Bye, Bye."]
  end

end
