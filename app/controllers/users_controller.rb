class UsersController < ApplicationController
  before_action :confirm_user_logged_in
  before_action :correct_user, only: [:edit, :update]
  before_action :confirm_admin, only: [:destroy, :new, :create]

  def new
    @user = User.new
  end

  def index
    @users = User.all.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "User created."
      redirect_to users_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @checkouts = User.find_by(id: @user.id).checkouts.order('created_at DESC').paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # Make sure only admin user is able to submit form with admin attribute
    if !@user.admin? && user_params.include?("admin")
      render 'edit'
    else
      if @user.update_attributes(user_params)
        flash[:success] = "Profile Updated"
        redirect_to @user
      else
        render 'edit'
      end
    end
  end

  def destroy
    devices = User.find(params[:id]).devices
    devices.each do |device|
      device.update_attribute(:available, true)
    end
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    ######## Before filters ########

    # Confirms current user is the logged in user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
