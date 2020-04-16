class SessionsController < ApplicationController
  def create
    User.create(request.env["omniauth.auth"])
      session[:user_id] = user.id
    redirect_to "/"
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are now logged out."
    redirect_to "/"
  end
end
