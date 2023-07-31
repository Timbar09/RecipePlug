class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes.order(created_at: :desc)
  end
end
