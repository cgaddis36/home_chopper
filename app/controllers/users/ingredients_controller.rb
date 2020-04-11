class Users::IngredientsController < ApplicationController

  def index
    @ingredients = User.find(params[:user_id]).ingredients
  end

  def create
    user = User.find(params[:user_id])
    new_ingredient = user.ingredients.new(ingredient_params)
    if new_ingredient.save
      flash[:success] = "New Item Saved"
      redirect_to "/users/#{user.id}/ingredients"
    else
      flash[:error] = "Name Can Not Be Blank"
      redirect_to "/users/#{user.id}/ingredients"
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:ingredient_id])
    if ingredient.destroy
      flash[:success] = "Ingredient Removed From Pantry"
    end
    redirect_to "/users/#{current_user.id}/ingredients"
  end



  private

  def ingredient_params
    params.permit(:name)
  end


end
