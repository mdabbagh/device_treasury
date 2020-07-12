require 'test_helper'

class DevicesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @avail_device = devices(:availDevice)
    @non_avail_device = devices(:unavailDeviceOne)
  end

  test "should get new" do
    log_in_as(@admin)
    get new_device_path
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@admin)
    get edit_device_path(@avail_device)
    assert_response :success
  end

  test "should get index" do
    log_in_as(@admin)
    get devices_path
    assert_response :success
  end

  test "non-admin should not be able to create a device" do
    log_in_as(@non_admin)
    get new_device_path
    assert_difference 'Device.count', 0 do
      post devices_path, params: {device: {tag: "TD1", category: "Phone", 
        make: "Apple", model: "iPhone SE", color: "black", memory: "256", os: "iOS 14"}}
    end
    assert_redirected_to root_url
  end

  test "admin should be able to create a device" do
    log_in_as(@admin)
    get new_device_path
    assert_difference 'Device.count', 1 do
      post devices_path, params: {device: {tag: "TD2", category: "Phone", 
        make: "Apple", model: "iPhone SE", color: "black", memory: "256", os: "iOS 14"}}
    end
    assert_redirected_to devices_url
  end

  test "should not be able to checkout an unavailable device" do
    log_in_as(@admin)
    get devices_path
    assert_difference 'Checkout.count', 0 do
      post checkout_path, params: {id: @non_avail_device.id}
    end
  end

  test "should be able to checkout an available device" do
    log_in_as(@non_admin)
    get devices_path
    assert_difference 'Checkout.count', 1 do
      post checkout_path, params: {id: @avail_device.id}
    end
    assert_redirected_to devices_url
  end
end
