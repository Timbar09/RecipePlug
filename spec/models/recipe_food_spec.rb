require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'creation' do
    before :each do
      @user = User.create(name: 'John Doe', email: 'john.doe@mail.com', password: 'password')

      @food = Food.create(name: 'Chicken', quantity: 4, price: 24.95, measurement_unit: 'lbs', user: @user)
      @recipe = Recipe.create(name: 'Chicken Parmesan', preparation_time: 10, cooking_time: 30,
                              description: 'This is a description', user: @user)
      @recipe_food = RecipeFood.create(recipe: @recipe, food: @food, quantity: 2)
    end

    it 'can be created' do
      expect(@recipe_food).to be_valid
    end

    it 'cannot be created without a recipe' do
      @recipe_food.recipe = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'cannot be created without a food' do
      @recipe_food.food = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'cannot be created without a quantity' do
      @recipe_food.quantity = nil
      expect(@recipe_food).to_not be_valid
    end

    it 'cannot be created with a quantity less than 0' do
      @recipe_food.quantity = -1
      expect(@recipe_food).to_not be_valid
    end
  end
end
