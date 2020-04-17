class RecipesController < ApplicationController
  def index
    ingredients = (params[:ingredient_1] + "," + params[:ingredient_2] + "," +
    params[:ingredient_3] + "," + params[:ingredient_4] + "," +
    params[:ingredient_5] + "," + params[:ingredient_6] + "," + params[:ingredient_7])
    search = RecipeSearch.new(ingredients)
    @recipes = search.get_recipe_names
  end
end
