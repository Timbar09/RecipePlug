class RecipeFoodsController < ApplicationController
  before_action :set_recipe, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_ingredient, only: [:edit, :update, :destroy]

  def new
    @ingredient = RecipeFood.new
  end

  def create
    @ingredient = @recipe.recipe_foods.build(recipe_food_params)

    if @ingredient.save
      redirect_to @recipe, notice: 'Ingredient added successfully.'
    else
      render :new, alert: 'Error: Failed to add ingredient.'
    end
  end

  def edit; end

  def update
    if @ingredient.update(recipe_food_params)
      redirect_to @recipe, notice: 'Ingredient updated successfully.'
    else
      render :edit, alert: 'Failed to update ingredient.'
    end
  end

  def destroy
    if @ingredient.destroy
      redirect_to @recipe, notice: 'Ingredient deleted successfully.'
    else
      redirect_to @recipe, alert: 'Failed to delete ingredient.'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def set_ingredient
    @ingredient = @recipe.recipe_foods.find(params[:id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end