require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  before :all do
    @taker = User.create(name: 'The Undertaker', email: 'phenom@streak.wwe', password: 'password')

    @recipe = Recipe.create(name: 'Chicken Parmesan', preparation_time: 10, cooking_time: 30,
                            description: 'This is a description', user: @taker)
    @recipe2 = Recipe.create(name: 'Chicken Parmesan', preparation_time: 10, cooking_time: 30,
                             description: 'This is a description', user: @taker)
  end

  describe 'GET /recipes' do
    it 'should get recipes index and render the index template' do
      sign_in @taker
      get recipes_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)

      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe2.name)

      expect(response.body).to include(@recipe.description)
      expect(response.body).to include(@recipe2.description)
    end
  end

  describe 'GET /recipes/:id' do
    it 'should get a recipe and render the show template' do
      sign_in @taker
      get recipe_path(@recipe)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)

      expect(response.body).to include(@recipe.name)
      expect(response.body).to include(@recipe.description)
    end
  end

  describe 'GET /recipes/public_recipes' do
    it 'should get public recipes and render the public_recipes template' do
      sign_in @taker
      get public_recipes_recipes_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:public_recipes)
    end
  end

  describe 'GET /recipes/shopping_list' do
    it 'should get the shopping list and render the shopping_list template' do
      sign_in @taker
      get shopping_list_recipes_path

      expect(response).to have_http_status(200)
      expect(response).to render_template(:shopping_list)
    end
  end
end
