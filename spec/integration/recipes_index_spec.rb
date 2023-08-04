require 'rails_helper'

RSpec.describe 'Recipes#index', type: :system, js: true do
  before :each do
    @user = User.create(name: 'Test User', email: 'user@mail.com', password: 'password')
    @recipe = Recipe.create(name: 'Test Recipe', preparation_time: 10, cooking_time: 10,
                            description: 'Test Description', user: @user)
    @recipe2 = Recipe.create(name: 'Test Recipe 2', preparation_time: 10, cooking_time: 10,
                             description: 'Test Description', user: @user)

    visit recipes_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

  end

  it 'shows the recipe cards information' do
    expect(page).to have_content(@recipe.name)
    expect(page).to have_content(@recipe2.name)

    expect(page).to have_content(@recipe.description)
    expect(page).to have_content(@recipe2.description)
  end

  it 'takes you to the recipe show page' do
    click_link @recipe.name
    expect(page).to have_current_path(recipe_path(@recipe))
  end
end
