Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/auth/google_oauth2', as: :google_oauth2
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :challenges, only: [:index, :show]

  get '/users/:user_id/dashboard', to: 'users/dashboard#index'

  scope :users, module: :users do
    resources :ingredients, except: [:new, :show, :edit]
    resources :challenges, except: :destroy
    resources :ratings, only: :create
    resources :photos, only: :create
  end
end
