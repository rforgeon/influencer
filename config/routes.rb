Rails.application.routes.draw do

  devise_for :users

  root 'welcome#index'

  resources :brands do
    get 'benefits'
  end

  resources :users, only: [:show] do
    get 'dashboard'
  end

  resources :wrapped_link 


end
