class FoodsController < ApplicationController
  before_action :set_food, only: %i[edit update destroy]

  def index
    @foods = current_user.foods.order(created_at: :desc)

    if params[:sort_by] == 'name'
      @sort_by = 'name'
      @direction = params[:direction] || 'asc'
      @foods = @foods.order(name: @direction)
    else
      @sort_by = nil
      @direction = nil
      @foods = @foods.order(id: :asc)
    end
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to foods_url, notice: 'Food was successfully created.'
    else
      render :new, alert: 'Error: Food was not created.'
    end
  end

  def destroy
    if @food.recipe_foods.any?
      redirect_to foods_url, alert: 'Food is associated with a recipe and cannot be destroyed.'
    elsif @food.destroy
      redirect_to foods_url, notice: 'Food was successfully destroyed.'
    else
      redirect_to foods_url, alert: 'Error: Food was not destroyed.'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity, :user_id)
  end

  def set_food
    @food = Food.find(params[:id])
  end
end
