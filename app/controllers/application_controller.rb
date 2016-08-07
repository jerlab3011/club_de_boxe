class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to connexion_url
      end
    end
    
    # Returns the current logged-in user (if any).
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
