class SessionsController < ApplicationController
  def create
    if user = User.update_or_create(request.env["omniauth.auth"])
      session[:user_id] = user.id
    end
    redirect_to "/"
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "You are now logged out."
    redirect_to "/"
  end
end 