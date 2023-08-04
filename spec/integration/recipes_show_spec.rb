require 'rails_helper'

RSpec.describe 'Recipes#show', type: :system, js: true do
  before :each do
    @user = User.create(name: 'Test User', email: 'user@mail.com', password: 'password')
    @recipe = Recipe.create(name: 'Test Recipe', preparation_time: 10, cooking_time: 10,
                            description: 'Test Description', user: @user)

    visit recipe_path(@recipe)
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  it 'shows the recipe details information' do
    expect(page).to have_content(@recipe.name)

    expect(page).to have_content('Preparation time: 0.10 hours')
    expect(page).to have_content('Cooking time: 0.10 hours')

    expect(page).to have_content(@recipe.description)

    expect(page).to have_link('Generate shopping list')
    expect(page).to have_link('Add ingredient')
  end

  it 'takes you to the shopping list page' do
    click_link 'Generate shopping list'
    expect(page).to have_current_path(shopping_list_recipes_path(@recipe))
  end
end
