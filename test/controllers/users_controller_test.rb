require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new user signup" do
    get "/signup"
    assert_response :success
  end
end
