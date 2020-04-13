class Users::ChallengesController < Users::BaseController
  def new
    @challenge = Challenge.new(challenge_params)
  end

  def create
    challenge = current_user.challenges.new(challenge_params)
    if challenge.save
      flash[:success] = "New Game Started!"
      redirect_to "/users/#{current_user.id}/challenges/#{challenge.id}"
    else
      flash[:error] = challenge.errors.full_messages.to_sentence
      redirect_to "/users/#{current_user.id}/challenges/new"
    end
  end

  def show
    @challenge = Challenge.find(params[:challenge_id])
  end

  def update
    @challenge = Challenge.find(params[:challenge_id])
    if params[:game_event] == "start"
      @challenge.start_game
    elsif params[:game_event] == "playing"
      @challenge.start_game
    elsif params[:game_event] == "pause"
      @challenge.pause_game
    elsif params[:game_event] == "cancel"
      @challenge.cancel_game
    elsif params[:game_event] == "done"
      @challenge.finalize_game
    elsif params[:game_event] == "save_photo"
      # needs photo functionality added - active storage??
      @challenge.game_complete
    elsif params[:game_event] == "no_photo"
      @challenge.game_complete
    end
    redirect_to "/users/#{current_user.id}/challenges/#{@challenge.id}"
  end

  private

  def challenge_params
    params.permit(:time_limit, :basket_size, :meal_type, :game_status)
  end
end
