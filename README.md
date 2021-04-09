# README

# Rails-Engine
  * Rails-Engine is an API that allows users to run queries on a business database.  A can use queries to obtain information about merchants, items, and revenue.  Additionally, users can create, update, and delete an item.  

  https://github.com/Pragmaticpraxis37/rails-engine

## Authors

- **Adam Bowers** - github - https://github.com/Pragmaticpraxis

## Table of Contents

  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Method Highlights/Tests](#method-highlights/tests)
  - [Running the tests](#running-the-tests)
  - [API End Points](#api-end-points)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

### GemFile/Dependency

  ```  
  gem 'pry'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'simplecov'
  gem 'active_designer'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'hirb'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  ```

### Prerequisites

What things you need to install the software and how to install them

* rails
```sh
gem install rails --version 5.2.5
```

### Installing

    1. Clone this repository. 
    2. Install gem packages by running the `bundle install` in the terminal. 
    3. Setup the database by running the command `rails db:{drop,create,migrate,seed}` in the terminal. 

## Method Highlights/Tests

### Search for a merchant based on search criteria.  

```
def self.find_merchant(name)
  find_by("name ILIKE ?", "%#{name.downcase}%")
end
```

### Testing this Method
  - Happy and Sad Paths
    
```
describe 'Search Shows One Merchant By Name' do
  before :each do
    @merchant_1 = create(:merchant, name: "Ring World")
    @merchant_2 = create(:merchant, name: "Turing")
  end

  describe 'happy path' do
    it "shows one merchant that matches a search term" do
      get api_v1_find_merchant_by_name_path params: {name: "#{@merchant_1.name}"}

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_an(String)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to be_a(String)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
      expect(merchant[:data][:attributes][:name]).to eq("Ring World")
    end
  end

  describe 'sad path' do
    it "shows one merchant that matches a search term" do
      get api_v1_find_merchant_by_name_path params: {name: "zipper"}

      expect(response).to be_successful

      not_found = JSON.parse(response.body, symbolize_names: true)

      expect(not_found[:data]).to eq({})
    end
  end
end
```

## Running the tests

In order to run all tests and see coverage run:

  Run the command `bundle exec rspec` in the terminal. 
  
## API End Points

  ### Merchants
  * All Merchants - http://localhost:3000/api/v1/merchants optional query parameters: ?per_page=<number_per_page> and/or                       page=<page_number>
  * One Merchant  - http://localhost:3000/api/v1/merchants/{{merchant_id}} 
  * Find Merchant - http://localhost:3000/api/v1/merchants/find?name
  * Merchant's Items  - http://localhost:3000/api/v1/merchants/{{merchant_id}}/items
  * Merchant Most Revenue  - http://localhost:3000/api/v1/revenue/merchants?quantity=
  * Merchant's Most Sold Items  - http://localhost:3000/api/v1/merchants/most_items?quantity=
  * Single Mercant's Revenue  - http://localhost:3000/api/v1/revenue/merchants/{{merchant_id}}
  * Find Merchant by Name - http://localhost:3000/api/v1/merchants/find?name=

  ### Items

  * Items - http://localhost:3000/api/v1/items optional query parameters: ?per_page=<number_per_page>&page=                           <page_number>
  * One Item  - http://localhost:3000/api/v1/items/{{item_id}}
  * Create an Item  - Post 'http://localhost:3000/api/v1/items'
  * Update an Item  - Patch 'http://localhost:3000/api/v1/items'
  * Delete an Item  - Delete 'http://localhost:3000/api/v1/items/{{item_id}}'
  * Item Sold by a Merchant - http://localhost:3000/api/v1/items/{{item_id}}/merchant
  * Find Items name - http://localhost:3000/api/v1/items/find_all?name=
  * Find Items Price  - http://localhost:3000/api/v1/items/find?min_price= or max_price, or both
  * Find Items Ranked by Revenue  - http://localhost:3000/api/v1/revenue/items?quantity=

## Built With

  - Ruby/Rails

## License

  - MIT License 

## Acknowledgments

  - The Turing School of Software & Design instructors and students of the 2011 cohort. 
