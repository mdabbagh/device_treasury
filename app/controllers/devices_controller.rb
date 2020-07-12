class DevicesController < ApplicationController
  before_action :confirm_admin, only: [:destroy, :new, :create, :update, :edit]
  before_action :check_device_available, only: [:checkout]

  def new
    @device = Device.new
  end

  def edit
    @device = Device.find(params[:id])
  end

  def index
    @devices = Device.all.order('tag').paginate(page: params[:page])
  end

  def show
    @device = Device.find(params[:id])
    @checkouts = Device.find_by(id: @device.id).checkouts.order('created_at DESC').paginate(page: params[:page])
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      flash[:success] = "Device added successfully"
      redirect_to devices_url
    else
      flash[:error] = "Something went wrong when adding the device"
      render 'new'
    end
  end

  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(device_params)
      flash[:success] = "Device updated"
      redirect_to @device
    else
      render 'edit'
    end
  end

  def destroy
    Device.find(params[:id]).destroy
    flash[:success] = "Device deleted"
    redirect_to devices_url
  end

  def checkout
    @device = Device.find(params[:id])
    # build m2m relationship
    if @device.available?
      begin
        @device.checkouts.create!(user_id: current_user.id, action: :checkout)
        @device.update_attribute(:available, false)
        flash[:success] = "Device checked out"
        redirect_to devices_url
      rescue => exception
        flash[:fail] = "Something went wrong during checkout :("
        redirect_to devices_url
      end
    end
  end

  def checkin
    @device = Device.find(params[:id])
    begin
      @device.update_attribute(:available, true)
      @device.checkouts.create!(user_id: current_user.id, action: :checkin)
      flash[:success] = "Device checked in!"
      redirect_to devices_url
    rescue => exception
      flash[:fail] = "Something went wrong during check in :(" + exception.message
      redirect_to devices_url
    end
  end

  private
    # tag: User provided unique identifier for a device
    # features: Comma-separated list of features the device has
    def device_params
      params.require(:device).permit(:tag, :category, :make, :model, :color, :memory, :os, :features, :passcode)
    end

    def check_device_available
      @device = Device.find(params[:id])
      @device.available?
    end
end
