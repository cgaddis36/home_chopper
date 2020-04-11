Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/auth/google_oauth2', as: :google_oauth2
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :users do
    get '/:user_id/ingredients', to: 'ingredients#index'
    post '/:user_id/ingredients', to: 'ingredients#create'
    delete '/:user_id/ingredients/:ingredient_id', to: 'ingredients#destroy'
    get '/dashboard', to: 'dashboard#index'
  end


  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
