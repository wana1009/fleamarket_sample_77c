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

  resources :items, only: [:new, :index, :show, :create, :destroy] do

    collection do
      get 'search'
      get 'get_category_child', to: 'items#get_category_child'
      get 'get_category_grandchild', to: 'items#get_category_grandchild'
    end

    resources :orders, only: [:index] do
      collection do
        get 'done', to: 'orders#done'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :cards, only: [:create, :new, :show, :destroy] do
    member do
      post 'show', to: 'cards#show'
      get  'show', to: 'cards#show'
      delete 'destroy', as: 'destroy'
    end
    collection do
      get  'confirmation'
    end
  end
end
