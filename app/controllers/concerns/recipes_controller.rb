class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end
  
  def show
   @recipe = Recipe.find(params[:id]) 
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created successfully!"#This line generates a green flash message bar indicating success.
      redirect_to recipe_path(@recipe)#Takes user to recipe show page.
    else
      render 'new'
    end
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end

end