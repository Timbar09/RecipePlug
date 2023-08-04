require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before :each do
    @taker = User.create(name: 'The Undertaker', email: 'phenom@streak.wwe', password: 'password')

    @chicken = Food.create(name: 'Chicken', user: @taker, quantity: 1, measurement_unit: 'kg', price: 10.00)
    @apple = Food.create(name: 'Apple', user: @taker, quantity: 5, measurement_unit: 'unit', price: 1.00)
  end

  describe 'GET /foods' do
    it 'should get foods index and render the index template' do
      sign_in @taker
      get foods_path

      expect(response).to have_http_status(200)

      expect(response).to render_template(:index)

      expect(response.body).to include(@chicken.name)
      expect(response.body).to include(@apple.name)
    end
  end
end
