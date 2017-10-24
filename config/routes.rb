Rails.application.routes.draw do
  
  root "pages#home"#Root goes to pages controller, home action.
  get 'pages/home', to: 'pages#home'#Get the '/home' route and send it to the Pages Controller, home action.
  get '/about', to: 'pages#about'
  get '/help', to: 'pages#help'
  get '/chat', to: 'pages#chat'
  get '/ingredients', to: 'pages#ingredients'
  #get 'recipes', to: 'recipes#index'
  #get '/recipes/new', to: 'recipes#new', as: 'new_recipe'# "as: 'new_recipe'" adds "new_recipe(_path)" to the prefix.
  #get '/recipes/:id', to: 'recipes#show', as: 'recipe'# "as: 'recipe'" adds  "recipe(_path)" to the prefix.
  #post '/recipes', to: 'recipes#create'
  #The above commented routes are all replaced by the line below.
  resources :recipes
  
  get '/signup', to: 'chefs#new'#This line directs the '/signup' route to the chef controller, new action rather than the new route.
  resources :chefs, except: [:new]#Makes an exception of 'new' so that it is replaced by 'signup'.
  
  get '/login', to: 'sessions#new'#Goes to sessions controller, new action.
  post '/login', to: 'sessions#create'#This will submit/post the login new session form to the sessions controller, create action.
  delete '/logout', to: 'sessions#destroy'#This goes down the logout path to the sessions controller, destroy action. 
end
