Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index', as: :root
  get '/auth/google_oauth2', as: :google_oauth2
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :challenges, only: [:index, :show]

  namespace :users do
    get '/:user_id/dashboard', to: 'dashboard#index'
    get '/:user_id/ingredients', to: 'ingredients#index'
    post '/:user_id/ingredients', to: 'ingredients#create'
    delete '/:user_id/ingredients/:ingredient_id', to: 'ingredients#destroy'
    get '/:user_id/challenges/new', to: 'challenges#new'
    post '/:user_id/challenges', to: 'challenges#create'
    get '/:user_id/challenges', to: 'challenges#index'
    get '/:user_id/challenges/:challenge_id', to: 'challenges#show'
    patch '/:user_id/challenges/:challenge_id/update', to: 'challenges#update'
    get '/:user_id/challenges/:challenge_id/edit', to: 'challenges#edit', as: :edit

    get '/hints', to: 'games#hints'
    post '/:user_id/ratings', to: 'ratings#create'
  end

  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
