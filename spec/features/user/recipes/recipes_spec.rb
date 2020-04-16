require 'rails_helper'

RSpec.describe 'API call for recipes' do
#  "https://recipe-mircoservice.herokuapp.com/"
  it "can get recipe recommendations" do

    visit "/recipes/new"

    fill_in "ingredient_1", with: "chocolate"

    fill_in "ingredient_2", with: "flour"

    fill_in "ingredient_3", with: "butter"

    click_on "Find Recipes"

    expect(current_path).to eq("/recipes")

    expect(page).to have_content("Chocolate-Speckled Salted Shortbread")
    expect(page).to have_content("Chocolate Biscuits")
    save_and_open_page
  end
end
