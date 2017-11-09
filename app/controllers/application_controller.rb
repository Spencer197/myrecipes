class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_chef, :logged_in?#Makes these methods helper methods so they are available to the views.
  
  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]#Returns the current chef's id or (||) Finds chef_id only if user is loged in. - Chef_id is stored in browser's cookie.
  end
  
  def logged_in?
    !!current_chef# !! makes current_chef a boolean expression.
  end
  
  def require_user
    if !logged_in?# "If not (!) logged in..."
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
