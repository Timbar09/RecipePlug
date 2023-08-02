class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show update destroy]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def public_recipes
    @recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    unless @recipe.public || @recipe.user == current_user
      redirect_to recipes_path, alert: 'You do not have access to that recipe.'
      return
    end

    @ingredients = RecipeFood.where(recipe: @recipe).includes(:food, :recipe)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to recipe_path(@recipe), notice: 'Recipe created successfully.'
    else
      render :new, alert: 'Error: Recipe could not be created.'
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to(request.referrer || recipes_path, notice: 'Recipe deleted successfully')
    else
      redirect_to(request.referrer || recipes_path, alert: 'Error: Recipe could not be deleted')
    end
  end

  def shopping_list
    @foods = current_user.foods
    @foods.each do |food|
      food.quantity -= total_quantity_for_food(food)
    end

    @foods = @foods.select { |f| f.quantity.negative? }
    @foods.each { |f| f.quantity *= -1 }
    @total = calculate_total_price(@foods)
  end

  private

  def total_quantity_for_food(food)
    current_user.recipes.sum do |recipe|
      recipe.recipe_foods.includes(:food).where(food_id: food.id).sum(:quantity)
    end
  end

  def calculate_total_price(foods)
    foods.sum { |f| f.price * f.quantity }
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end