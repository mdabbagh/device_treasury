require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  def setup
    @device = Device.new(tag: "ATest", category: "Phone", make: "Apple", model: "iPhone XS", 
      color: "Black", os: "iOS 13", memory: 256, features: "Feature1,feature2", passcode: "123456")
  end

  test "should be valid" do
    assert @device.valid?
  end

  test "tag should be unique" do
    #device2 = Device.new(tag: "ATest", category: "Phone", make: "Apple", model: "iPhone XS", 
      #color: "Black", memory: 256, features: "Feature1, feature2", passcode: "123456")
  end

  test "category should be present" do
    @device.category = ""
    assert_not @device.valid?
  end

  test "make should be present" do
    @device.make = ""
    assert_not @device.valid?
  end

  test "model should be present" do
    @device.model = ""
    assert_not @device.valid?
  end

  test "color should be present" do
    @device.color = ""
    assert_not @device.valid?
  end

  test "memory should be present" do
    @device.memory = ""
    assert_not @device.valid?
  end

  test "os should be present" do
    @device.os = ""
    assert_not @device.valid?
  end
end
