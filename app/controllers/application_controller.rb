class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # Include session helper in all controllers
  before_action :confirm_user_logged_in

  private
  
    def confirm_user_logged_in
      unless logged_in?
        store_location # For friendly forwarding
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def confirm_admin
      redirect_to(root_url) unless current_user.admin?
    end
end
