Rails.application.routes.draw do
  
  root "pages#home"#Root goes to pages controller, home action.
  get '/about', to: 'pages#about'#Get the '/about' route and send it to the Pages controller, about action.
  get '/help', to: 'pages#help'#Get the '/help' route and send it to the pages controller, help action.
  get '/chefs', to: 'pages#chefs'
  get '/chat', to: 'pages#chat'
  get '/ingredients', to: 'pages#ingredients'
  get '/recipes', to: 'pages#recipes'
  #root "pages#home"
  #get 'pages/home', to: 'pages#home' 

resources :myrecipes
end
