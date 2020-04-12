class Users::ChallengesController < Users::BaseController

  def new
    @challenge = Challenge.new(challenge_params)
  end

  def create
    binding.pry
  end

  private

  def challenge_params
    params.permit(:time_limit, :basket_size, :meal_type)
  end
end
