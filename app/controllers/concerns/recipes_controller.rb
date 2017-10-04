class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update] #Runs set_recipe method only before show, edit, & update methods are run.
  
  def index
    @recipes = Recipe.all
  end
  
  def show
    #See set_recipe under private
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
    
    def edit
      #See set_recipe under private
    end
    
    def update
      #See set_recipe under private
      if @recipe.update(recipe_params)
        flash[:success] = "Recipe was updated successfully!"
        redirect_to recipe_path(@recipe)
      else
        render 'edit'
      end
    end
    
    def destroy
      Recipe.find(params[:id]).destroy
      flash[:success] = "Recipe deleted successfully"
      redirect_to recipes_path
    end
  
  private
  
    def set_recipe#This method eliminates the redunancy of '@recipe = Recipe.find(params[:id])' in the show, edit, and update methods.  
      @recipe = Recipe.find(params[:id])
    end
  
    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end

end