# rubocop:disable Style/ClassAndModuleChildren

class Users::DashboardController < Users::BaseController
  def index
    @user = current_user
  end
end

# rubocop:enable Style/ClassAndModuleChildren
