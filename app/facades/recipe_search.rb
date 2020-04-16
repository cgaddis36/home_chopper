class RecipeSearch

  def initialize(ingredients)
    @ingredients = ingredients
    @service = RecipeMicroservice.new
  end

  def get_recipe_names
    @recipe_json ||= @service.get_recipes(@ingredients)
    recipes = []
    @recipe_json.each do |recipe_data|
      recipes << Recipe.new(recipe_data, self)
    end
    recipes
  end

  # def get_recipe_instructions(id)
  #   @recipe_instructions_json ||= @service.get_recipe_instructions(id)
  # end

  def get_recipe_information(id)
    @recipe_ingredients_json ||= @service.get_recipe_info(id)
  end
end
