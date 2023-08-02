require 'rails_helper'

RSpec.describe Food, type: :model do
  describe 'creation' do
    before :each do
      @user = User.create(name: 'John Doe', email: 'john.doe@mail.com', password: 'password')

      @food = Food.create(name: 'Chicken', quantity: 1, price: 1.99, measurement_unit: 'lbs', user: @user)
    end

    it 'can be created' do
      expect(@food).to be_valid
    end

    it 'cannot be created without a name' do
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a name less than 2 characters' do
      @food.name = 'C'
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a name greater than 50 characters' do
      @food.name = 'C' * 51
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a quantity' do
      @food.quantity = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a quantity less than 0' do
      @food.quantity = -1
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a price' do
      @food.price = nil
      expect(@food).to_not be_valid
    end

    it 'cannot be created with a price less than 0' do
      @food.price = -1
      expect(@food).to_not be_valid
    end

    it 'cannot be created without a user' do
      @food.user = nil
      expect(@food).to_not be_valid
    end
  end
end
