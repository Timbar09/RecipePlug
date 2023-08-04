require 'rails_helper'

RSpec.describe 'Foods', type: :system, js: true do
  before :each do
    @user = User.create(name: 'Test User', email: 'user@mail.com', password: 'password')
    @banana = Food.create(name: 'Banana', measurement_unit: 'g', price: 0.10, quantity: 100, user: @user)
    @apple = Food.create(name: 'Apple', measurement_unit: 'units', price: 0.20, quantity: 100, user: @user)

    visit foods_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'

  end

  it 'shows the food page information' do
    expect(page).to have_content('Banana')
    expect(page).to have_content('Apple')

    expect(page).to have_content('$0.1')
    expect(page).to have_content('$0.2')

    expect(page).to have_content(@banana.measurement_unit)
    expect(page).to have_content(@apple.measurement_unit)
  end
end
