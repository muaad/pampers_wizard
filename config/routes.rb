require "sidekiq/web"
Rails.application.routes.draw do
	mount Sidekiq::Web => '/sidekiq'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'home#index'
  post "home/wizard"
  devise_for :users
end
