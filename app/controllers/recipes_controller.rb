class RecipesController < ApplicationController

  def index
    ingredients = params[:ingredient_1] + "," + params[:ingredient_2] + "," + params[:ingredient_3]
    @recipes = RecipeSearch.new(ingredients)
    conn = Faraday.new(url: "https://recipe-mircoservice.herokuapp.com")

    response = conn.get('/recipe-recommendations') do |req|
      req.params['ingredients'] = ingredients
      req.params['limit'] = 2
    end
    json = JSON.parse(response.body, symbolize_names: true)
    @recipes = json
    binding.pry
  end
end

@facade ||= 
