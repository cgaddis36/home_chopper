class Users::IngredientsController < Users::BaseController
  def index
    @ingredients = User.find(params[:user_id]).ingredients
  end

  def create
    user = User.find(params[:user_id])
    new_ingredient = user.ingredients.new(ingredient_params)
    if new_ingredient.save
      flash[:success] = "New Item Saved"
    else
      flash[:error] = "Name Can Not Be Blank"
    end
    redirect_to "/users/#{user.id}/ingredients"
  end

  def destroy
    ingredient = Ingredient.find(params[:ingredient_id])
    flash[:success] = "Ingredient Removed From Pantry" if ingredient.destroy
    redirect_to "/users/#{current_user.id}/ingredients"
  end

  private

  def ingredient_params
    params.permit(:name)
  end
end
