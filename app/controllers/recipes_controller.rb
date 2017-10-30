class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy] #Runs set_recipe method only before show, edit, & update methods are run.
  before_action :require_user, except: [:index, :show]#Requires a logged in user for all actions except index & show.
  before_action :require_same_user, only: [:edit, :update, :destroy]#Only the user who created a recipes may edit, update, or destroy it.
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)# replaces @recipes = Recipe.all - organizes data into 5 recipes per page.
  end
  
  def show
    #See set_recipe under private
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)#Creates new Recipe object.
    @recipe.chef = current_chef# Replaces: @recipe.chef = Chef.first - Assigns current_user as creator of a recipe.
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
      params.require(:recipe).permit(:name, :description, ingredient_ids: [])#Permits name, description & ingredient_ids as recipe params.
    end
    
    def require_same_user
      if current_chef != @recipe.chef and !current_chef.admin?
        flash[:danger] = "You can only edit and delete your own recipes."
        redirect_to recipes_path
      end
    end

end