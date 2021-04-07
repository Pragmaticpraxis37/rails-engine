Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'search#find_merchant_by_name', as: 'find_merchant_by_name'
      get '/items/find', to: 'search#find_item_by_name_or_description_or_price', as: 'find_item_by_name_or_description_or_price'
      resources :merchants, only: [:index, :show]
      resources :items
      get '/items/:id/merchant', to: 'item_merchant#show', as: 'items_merchant'
    end
  end
end
