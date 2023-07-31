class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end

  def show; end

  def destroy
    if @recipe.destroy
      redirect_to(request.referrer || recipes_path, notice: "Recipe deleted successfully")
    else
      redirect_to(request.referrer || recipes_path, alert: "Error: Recipe could not be deleted")
    end
  end

  private

  def set_recipe
    @recipe = current_user.recipes.find(params[:id])
  end
end
