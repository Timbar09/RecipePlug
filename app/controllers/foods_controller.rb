class FoodsController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = Food.all.where(user_id: current_user.id)

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

  def show; end

  def new
    @food = Food.new
  end

  def edit; end

  def create
    @food = current_user.foods.new(food_params)

    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_url, notice: 'Food was successfully created.' }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
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
