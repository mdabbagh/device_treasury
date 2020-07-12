require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should only get new if admin" do
    get signup_path
    assert_response :redirect
  end

  # Next 2 tests needed to ensure before_action works as expected
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
      email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {name: @user.name, email: @user.email }}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path # index
    assert_redirected_to login_url
  end

  test "admin should not be editable via web request" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {user: { 
      password: "password",
      password_confirmation: "password",
      admin: true
    }}
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy to login page when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy to homepage when not admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "non-admin user should not be able to create a user" do
    log_in_as(@other_user)
    get new_user_path
    assert_difference 'User.count', 0 do
      post users_path, params: {user: {name: "test user created by nonadmin", email: "blahblah@notadmin.com", 
        password: "password", password_confirmation: "password", admin: false}}
    end
  end

  test "admin user should be able to create a user" do
    log_in_as(@user)
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {name: "test user created by admin", email: "blahblah@admin.com", 
        password: "password", password_confirmation: "password", admin: false}}
    end
    assert_redirected_to users_url
  end
end
