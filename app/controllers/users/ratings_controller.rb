class Users::RatingsController < Users::BaseController

def create
  rating = Rating.create(rating_params)
  redirect_to "/challenges/#{params[:challenge_id]}"
end

private

  def rating_params
    params.permit(:challenge_id, :user_id, :stars)
  end
end
