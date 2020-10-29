Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'

  resources :items do
    collection do
      get 'search'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'update_done'
    end
  end

  resources :users, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
