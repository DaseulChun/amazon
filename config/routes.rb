Rails.application.routes.draw do
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  controller :welcome do
    get :index
    get :home
    get :about
    get :contact_us
    get :bill_splitter
  end

  # products new page - shows a form to create a product
  get '/products/new', {to: 'products#new', as: :new_product}

  # create products
  post '/products', {to: 'products#create', as: :products}

  # show product page
  get '/products/:id', {to: 'products#show', as: :product}

  # products index page
  get '/products', {to: 'products#index'}

  # product edit page
  get '/products/:id/edit', {to: 'products#edit', as: :edit_product}

  # update action handles the submission of form from the product edit page
  patch '/products/:id', {to: 'products#update'}

  # delete product and then redirect to the index page
  delete '/products/:id', {to: 'products#destroy', as: :delete_product}

  # routes of reviews
  resources :products do
    resources :reviews, only:
    [:create, :destroy]
  end
end

