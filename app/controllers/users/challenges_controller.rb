class Users::ChallengesController < Users::BaseController

  def new
    @challenge = Challenge.new(challenge_params)
  end

  def create
    user = User.find(params[:user_id])
    challenge = user.challenges.new(challenge_params)
    if challenge.save
      flash[:success] = "New Game Started!"
      redirect_to "/users/#{user.id}/challenges/#{challenge.id}"
    else
      flash[:error] = challenge.errors.full_messages.to_sentence
      render :new
    end

    def show
      @challenge = Challenge.find(params[:challenge_id])
    end
  end

  private

  def challenge_params
    params.permit(:time_limit, :basket_size, :meal_type, :game_status)
  end
end
