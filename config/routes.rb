Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/auth/google_oauth2', as: :google_oauth2
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :challenges, only: [:index, :show]

  scope :users, module: :users do
    resources :dashboard
    resources :ingredients, except: [:new, :show, :edit]
    resources :challenges, except: :destroy
    resources :ratings, only: :create
  end
end
