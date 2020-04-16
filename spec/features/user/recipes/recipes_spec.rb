require 'rails_helper'

RSpec.describe 'API call for recipes' do
#  "https://recipe-mircoservice.herokuapp.com/"
  it "can get recipe recommendations" do

    visit "/recipes"

    fill_in "ingredient", with: "chocolate"

    click_on "Add Ingredient to Search"

    fill_in "ingredient", with: "flour"

    click_on "Add Ingredient to Search"

    fill_in "ingredient", with: "butter"

    click_on "Find Recipes"

    expect(current_path).to eq("/recipes/index")

    expect(page).to have_content("Chocolate-Speckled Salted Shortbread")
    expect(page).to have_content("Chocolate Biscuits")
  end
end
