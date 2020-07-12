require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @inactive_user = users(:inactive)
    @active_user = users(:michael)
  end
end
