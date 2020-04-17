# rubocop:disable Style/ClassAndModuleChildren
# rubocop:disable Style/IfUnlessModifier

class Users::IngredientsController < Users::BaseController
  def index
    @ingredients = User.find(current_user.id).ingredients
  end

  def create
    user = User.find(current_user.id)
    new_ingredient = user.ingredients.new(ingredient_params)
    if new_ingredient.save
      flash[:success] = "New Item Saved"
    else
      flash[:error] = "Name Can Not Be Blank"
    end
    redirect_to "/users/ingredients"
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    if ingredient.destroy
      flash[:success] = "Ingredient Removed From Pantry"
    end
    redirect_to "/users/ingredients"
  end

  private

  def ingredient_params
    params.permit(:name)
  end
end

# rubocop:enable Style/IfUnlessModifier
# rubocop:enable Style/ClassAndModuleChildren
