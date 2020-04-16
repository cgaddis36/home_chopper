class RecipeSearch

  def initialize(ingredients)
    @ingredients = ingredients
    @service = RecipeMicroservice.new
  end

  def get_recipe_names
    @recipe_json ||= @service.get_recipes(@ingredients)
    recipes = []
    @recipe_json.each do |recipe_data|
      recipes << Recipe.new(recipe_data)
    end
    recipes
  end
  #
  # def get_recipe_instructions(id)
  #   @recipe_instructions_json ||= @service.get_recipes(@ingredients)
  # end
end
