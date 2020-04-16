class RecipeMicroservice
  def get_recipes(ingredients)
    response = conn.get('/recipe-recommendations') do |req|
      req.params['ingredients'] = ingredients
    end
      get_json(response)
  end

  # def get_recipe_instructions(id)
  #   response = conn.get('') do |req|
  #     req.params['id'] = id
  #   end
  #   get_json(response)
  # end

 private

  def conn
   conn = Faraday.new(url: "https://recipe-mircoservice.herokuapp.com")
  end

  def get_json(response)
    json = JSON.parse(response.body, symbolize_names: true)
  end
end
