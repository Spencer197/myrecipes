class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)# Replaces @chefs = Chef.all - Arranges chefs index data into 5 chefs per page.
  end
  
  def new
    @chef = Chef.new
  end
  
  def create
    #@chef = Chef.new(chef_params) - See set_chef method below.
    if @chef.save
      session[:chef_id] = @chef.id#Logs in a new user as soon as he/she signs up for a new account.
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end
  
  def show
    #@chef = Chef.find(params[:id])#Finds chef id params from database to view on chef profile page. - See set_chef method below.
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)#defines new instance var @chef_recipes & paginates chefs data.
  end
  
  def edit
    #@chef = Chef.find(params[:id]) - See set_chef method below.
  end
  
  def update
    #@chef = Chef.find(params[:id]) - See set_chef method below.
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated successfully"
      redirect_to @chef
    else
      render 'edit'
    end
  end
  
  def destroy
    #@chef = Chef.find(params[:id])#Find the chef to be deleted - See set_chef method below.
    @chef.destroy#Destroy/delete the selected chef
    flash[:danger] = "Chef & all associated recipes have been deleted!"#Display a flash message
    redirect_to chefs_path#Return to the dhefs listing.
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end
  
  def set_chef
    @chef = Chef.find(params[:id])
  end
  
  def require_same_user
    if current_chef != @chef
      flash[:danger] = "You can only edit and delete your own account."
      redirect_to chefs_path
    end
  end
  

end
