class Recipe
  attr_reader :ingredients, :title, :instructions

  def initialize(data, search_facade)
    @search_facade = search_facade
    @title = data[:title]
    @ingredients = ingredients_pull(data[:id])
    @instructions = instructions_pull(data[:id])
  end

  def ingredients_pull(id)
    recipe_data = @search_facade.get_recipe_information(id)
    recipe_data[:extendedIngredients].map do |ingredient|
      ingredient[:originalString]
    end
  end

  def instructions_pull(id)
    recipe_data = @search_facade.get_recipe_information(id)
    recipe_data[:instructions]
  end

end
