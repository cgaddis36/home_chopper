# rubocop:disable Style/ClassAndModuleChildren

class Users::ChallengesController < Users::BaseController
  def index
  end

  def new
    @challenge = Challenge.new(challenge_params)
  end

  def create
    challenge = current_user.challenges.new(challenge_params)
    if challenge.save
      flash[:success] = "New Game Started!"
      redirect_to "/users/challenges/#{challenge.id}"
    else
      flash[:error] = challenge.errors.full_messages.to_sentence
      redirect_to "/users/challenges/new"
    end
  end

  def show
    @challenge = Challenge.last
  end

  def update
    @challenge = Challenge.find(params[:id])
    if params[:game_event] == "cancel"
      @challenge.cancel_game
    elsif params[:game_event] == "done"
      @challenge.finalize_game
    elsif params[:game_event] == "no_photo"
      @challenge.game_complete
    end
    redirect_to "/users/challenges/#{@challenge.id}"
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  private

  def challenge_params
    if params[:challenge]
      params.require(:challenge).permit(:time_limit, :basket_size, :meal_type)
    else
      params.permit(:time_limit, :basket_size, :meal_type, :game_status)
    end
  end
end

# rubocop:enable Style/ClassAndModuleChildren
