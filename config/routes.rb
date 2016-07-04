Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks}

  resources :exams, only: [:index, :create]
  namespace :admin do
    root "subjects#index"
    resources :subjects
    resources :users, only: [:index, :show, :destroy]
    resources :questions, only: [:index, :new, :create]
  end
end
