class ApplicationController < ActionController::Base
  helper_method :current_user,
                :game_start

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
