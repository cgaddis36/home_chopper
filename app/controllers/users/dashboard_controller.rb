class Users::DashboardController < Users::BaseController
  def index
    @user = current_user
  end
end
