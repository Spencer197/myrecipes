Rails.application.routes.draw do
  
  root "pages#home"#Root goes to pages controller, home action.
  get 'pages/home', to: 'pages#home'#Get the '/home' route and send it to the Pages Controller, home action.
  
  get 'recipes', to: 'recipes#index'
end
