class PagesController < ApplicationController
  
  def home
    redirect_to recipes_path if logged_in? #If chef logged in, recipes become the home page.
  end
  
  def about
    
  end
  
  def help
    
  end
  
  def chefs
    
  end
  
  def chat
    
  end
  
  def ingredience
    
  end
  
  def recipes
    
  end
end