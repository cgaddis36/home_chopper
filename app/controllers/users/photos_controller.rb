class Users::PhotosController < Users::BaseController

  def create
    challenge = Challenge.find(params[:challenge_id])
    challenge.photos.create(photo_params)
    challenge.game_complete
    redirect_to "/users/challenges/#{challenge.id}"
  end

  private

  def photo_params
    params.permit(:image)
  end
end
