Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'search#find_merchant_by_name', as: 'find_merchant_by_name'
      get '/items/find_all', to: 'search#find_all_items_by_name_or_description_or_price', as: 'find_all_items_by_name_or_description_or_price'
      get 'revenue/items', to: 'item_revenue#most_revenue'
      get '/revenue/merchants', to: 'merchant_revenue#most_revenue'
      get '/merchants/most_items', to: 'merchant_most_items#most_items'
      get '/revenue/merchants/:id', to: 'merchant_revenue#most_revenue_one_merchant'
      resources :merchants, only: [:index, :show]
      resources :items
      get '/items/:id/merchant', to: 'item_merchant#show', as: 'items_merchant'
      get '/merchants/:id/items', to: 'merchant_item#index', as: 'merchant_items'
    end
  end
end








# get '/merchants/find_all', to: 'search#find_all_merchants_by_name', as: 'find_all_merchants_by_name'
