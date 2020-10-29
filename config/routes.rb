Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  get 'orders/index'
  get 'orders/done'
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
    end

    resource :orders do
      member do
        get  "buy"
        post "pay"
      end
    end
  end

  resources :users, only: :show do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end

  resources :cards, only: [:index, :new, :create, :show, :destroy] do
  end
end
