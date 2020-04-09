class SessionsController < ApplicationController
  # def create 

  #   render plain: request.env["omniauth.auth"]
  #   # request.env['omniauth.auth']
  #   # render text: request.env['omniauth.auth'].inspect
  # end

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
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