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

  #   # resources :buyers, only: [:index] do
  #     collection do
  #       get 'done', to: 'buyers#done'
  #       post 'pay', to: 'buyers#pay'
  #     end
  #   end
  # end

  #   resources :orders, only: [:index, :create] do
  #     member do
  #       get  "buy"
  #       post "pay"
  #     end
  #   end
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
  
  resources :cards, only: [:new, :create] do
  end
end
