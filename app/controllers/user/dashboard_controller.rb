class User::DashboardController < User::BaseController
  def index
    if current_user
      @user = current_user
    else
      redirect_to '/'
    end
  end
end
