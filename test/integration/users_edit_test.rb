require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
      email: "foo@invalid", password: "ha", confirm_password: "haha"}}
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 3 errors."
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user) # Get redirected here from previous step
    assert_redirected_to edit_user_path(@user)
    updated_name = "Updated Name"
    updated_email = "updatedemail@example.com" # Must be lower case as we enforce this when saving to db
    patch user_path(@user), params: { user: { name: updated_name, 
      email: updated_email, password: "", confirm_password: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    assert_nil session[:forwarding_url]
    @user.reload # Reloads user data from db
    assert_equal updated_name, @user.name
    assert_equal updated_email, @user.email
  end

end
