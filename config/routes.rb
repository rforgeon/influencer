Rails.application.routes.draw do

  devise_for :users

  root 'welcome#index'

  get 'welcome/rankDescription'

  get 'welcome/rewards'

  resources :brands do
    get 'benefits'
    get 'dashboard'
    get 'register'
  end

  resources :users, only: [:show] do
    get 'dashboard'
    get 'metrics'
  end

  resources :wrapped_links do
    get 'rebrandly_link'
  end

  scope '/ga', :controller => :google_analytics do
        get :sessions
      end


end
