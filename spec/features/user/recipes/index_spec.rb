require 'rails_helper'

RSpec.describe 'API call for recipes' do
  xit "can get recipe recommendations" do
    visit "/recipes/new"

    fill_in "ingredient_1", with: "chocolate"

    fill_in "ingredient_2", with: "flour"

    fill_in "ingredient_3", with: "butter"

    click_on "Find Recipes"

    expect(current_path).to eq("/recipes")

    expect(page).to have_content("Here Are a Few Recipes You Might Like")
    expect(page).to have_content("Chocolate Melting Cake")
    expect(page).to have_content("1 cup butter")
    expect(page).to have_content("7 eggs")
    expect(page).to have_content("8 ounces semi-sweet chocolate")
    expect(page).to have_content("7 tablespoons sugar")
    expect(page).to have_content("Preheat oven to 375 degrees.Melt together chocolate and butter.")
    expect(page).to have_content("Chocolate-Speckled Salted Shortbread")
    expect(page).to have_content("1/4 teaspoon coarse salt, such as fleur de sel")
    expect(page).to have_content("2 ounces dark chocolate, very finely chopped")
    expect(page).to have_content("1 & 3/4 cup all-purpose flour")
    expect(page).to have_content("1/4 cup granulated sugar")
    expect(page).to have_content("1/4 cup packed light brown sugar")
    expect(page).to have_content("1 teaspoon salt")
    expect(page).to have_content("3/4 cup unsalted butter, softened")
    expect(page).to have_content("1/2 teaspoon vanilla")
    expect(page).to have_content("1 tablespoon water, if necessary")
    expect(page).to have_content("1/2 teaspoon vanilla")
    expect(page).to have_content("Using an electric mixer on medium speed, beat butter, sugar, brown sugar, and vanilla until fluffy.")
    expect(page).to have_content("Chocolate Biscuits")
    expect(page).to have_content("3 oz (80g) soft brown sugar")
    expect(page).to have_content("2 oz (50g) dark chocolate (you can use chocolate chips as well)")
    expect(page).to have_content("1 egg yolk")
    expect(page).to have_content("7 oz (200g) flour, sifted")
    expect(page).to have_content("7 oz (200g) salted butter, chilled")
    expect(page).to have_content("unsweetened cocoa powder, sifted")
    expect(page).to have_content("Preheat the oven to 355F. Line a baking sheet with baking parchment.")
  end
end
