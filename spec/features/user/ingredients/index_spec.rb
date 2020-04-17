require 'rails_helper'

describe "ingredients index" do
  before(:each) do
    @bob = User.create(name: "Bob", email: "bob@sample.com", google_token: "12345", role: 0)
    @chocolate = @bob.ingredients.create(name: "Chocolate")
    @squid = @bob.ingredients.create(name: "Squid")
    @crab = @bob.ingredients.create(name: "Crab")
    @blueberries = @bob.ingredients.create(name: "Blueberries")
    @cinnamon = @bob.ingredients.create(name: "Cinnamon")
    @eggs = @bob.ingredients.create(name: "Eggs")
    @toast = @bob.ingredients.create(name: "Toast")
    @bobs_breakfast = @bob.challenges.create!(time_limit: 20, basket_size: 3, meal_type: "breakfast")
    ChallengeIngredient.create!(challenge_id: @bobs_breakfast.id, ingredient_id: @crab.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@bob)
  end

  it "lists all user ingredients" do
    visit "/users/ingredients"

    within('.ingredients') do
      expect(page).to have_content(@chocolate.name)
      expect(page).to have_content(@squid.name)
      expect(page).to have_content(@blueberries.name)
      expect(page).to have_content(@cinnamon.name)
      expect(page).to have_content(@eggs.name)
      expect(page).to have_content(@toast.name)
    end
  end

  it "can add a food to the pantry " do
    visit "/users/ingredients"

    fill_in "Name", with: "Tomato Sauce"

    click_on "Add Item To Pantry"

    expect(current_path).to eq("/users/ingredients")

    within('.ingredients') do
      expect(page).to have_content(@chocolate.name)
      expect(page).to have_content(@squid.name)
      expect(page).to have_content(@blueberries.name)
      expect(page).to have_content(@cinnamon.name)
      expect(page).to have_content(@eggs.name)
      expect(page).to have_content(@toast.name)
      expect(page).to have_content("Tomato Sauce")
    end
  end

  it "cannot add a food to the pantry without a name" do
    visit "/users/ingredients"

    fill_in "Name", with: ""

    click_on "Add Item To Pantry"

    expect(current_path).to eq("/users/ingredients")

    expect(page).to have_content("Name Can Not Be Blank")

    within('.ingredients') do
      expect(page).to have_content(@chocolate.name)
      expect(page).to have_content(@squid.name)
      expect(page).to have_content(@blueberries.name)
      expect(page).to have_content(@cinnamon.name)
      expect(page).to have_content(@eggs.name)
      expect(page).to have_content(@toast.name)
    end
  end

  it "can delete a food from the pantry" do
    visit "/users/ingredients"

    within("#ingredient-#{@crab.id}") do
      click_on "Remove From Pantry"
    end

    expect(current_path).to eq("/users/ingredients")
    expect(page).to have_content("Ingredient Removed From Pantry")

    within('.ingredients') do
      expect(page).to have_content(@chocolate.name)
      expect(page).to have_content(@squid.name)
      expect(page).to_not have_content(@crab.name)
      expect(page).to have_content(@blueberries.name)
      expect(page).to have_content(@cinnamon.name)
      expect(page).to have_content(@eggs.name)
      expect(page).to have_content(@toast.name)
    end
  end
end
