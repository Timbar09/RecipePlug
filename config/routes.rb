Rails.application.routes.draw do
  devise_for :users
  resources :foods
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"

  resources :recipes, except: [:edit] do
    collection do
      get :public_recipes
      get :shopping_list
    end
    resources :recipe_foods, except: [:show, :index]
  end
end