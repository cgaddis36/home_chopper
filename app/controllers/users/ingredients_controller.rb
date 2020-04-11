class Users::IngredientsController < ApplicationController

  def index
    @ingredients = User.find(params[:user_id]).ingredients
  end

  def create
    user = User.find(params[:user_id])
    if user.ingredients.create(ingredient_params)
      redirect_to "/users/#{user.id}/ingredients"
    else
      flash[:error] = "Name Can Not Be Blank"
    end
  end


  private

  def ingredient_params
    params.permit(:name)
  end


end
