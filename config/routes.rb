Rails.application.routes.draw do
  root "static_pages#home"
  get "home" => "static_pages#home"
  devise_for :users

  namespace :admin do
    root "subjects#index"
    resources :subjects
  end
end
