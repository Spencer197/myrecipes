class SessionsController < ApplicationController

  def new
  # Serves/renders the login form.
  end

  def create# Handles the form submission, creates the session, & moves user to a logged in state. 
    chef = Chef.find_by(email: params[:session][:email].downcase)#Finds chef by email.
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id#Saves the encrypted chef_id in the session hash.
      cookies.signed[:chef_id] = chef.id#Saves the encrypted chef_id in the cookies; not just in the session hash only.
      flash[:success] = "You have successfully logged in."
      redirect_to chef
    else
      flash.now[:danger] = "There was something wrong with your login information."#This flash is needed here because a session is not a model based resource, so the error partial is not availabe for this action.
      render 'new'
    end
  end

  def destroy# Handles the logout. Ends the session or simulates a logged out state.
    session[:chef_id] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end
  
end