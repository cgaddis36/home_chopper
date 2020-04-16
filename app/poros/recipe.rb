class Recipe
  attr_reader :ingredients, :title

  def initialize(data)
    @title = data[:title]
    @ingredients = ingredient_pull(data)
  end

  def ingredient_pull(data)
    data[:missedIngredients].map do |ingredient|
      ingredient[:name]
    end
  end
end
