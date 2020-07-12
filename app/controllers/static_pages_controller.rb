class StaticPagesController < ApplicationController
  skip_before_action :confirm_user_logged_in, only: [:home]
  
  def home
    @checkouts = (Checkout.order('created_at DESC').all).paginate(page: params[:page])
  end
end