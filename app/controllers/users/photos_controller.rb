class Users::PhotosController < Users::BaseController

  def create
    challenge = Challenge.last
    challenge.photos.create(photo_params)
    challenge.game_complete
    redirect_to "/users/challenges/#{challenge.id}"
  end

  private

  def photo_params
    params.permit(:image)
  end
end
