require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'creation' do
    before :each do
      @user = User.create(name: 'John Doe', email: 'john.doe@mail.com', password: 'password')
      
      @recipe = Recipe.create(name: 'Chicken Parmesan', preparation_time: 10, cooking_time: 30,
                              description: 'This is a description', user: @user)
    end

    it 'can be created' do
      expect(@recipe).to be_valid
    end

    it 'can be created with a public value that is a boolean' do
      @recipe.public = true
      expect(@recipe).to be_valid
    end

    it 'cannot be created without a name' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a name less than 2 characters' do
      @recipe.name = 'C'
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a name greater than 50 characters' do
      @recipe.name = 'C' * 51
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a preparation time' do
      @recipe.preparation_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a preparation time less than 0' do
      @recipe.preparation_time = -1
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a cooking time' do
      @recipe.cooking_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a cook time less than 0' do
      @recipe.cooking_time = -1
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a description less than 1 character' do
      @recipe.description = ''
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created with a description greater than 300 characters' do
      @recipe.description = 'T' * 301
      expect(@recipe).to_not be_valid
    end

    it 'cannot be created without a user' do
      @recipe.user = nil
      expect(@recipe).to_not be_valid
    end
  end
end
