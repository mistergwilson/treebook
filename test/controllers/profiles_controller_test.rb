require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: users(:gregory).user_name
    assert_response :success
  end

  test "that variables are assigned on successful profile viewing" do
  	get :show. id: users(:gregory).user_name
  	assert assigns(:user)
  	assert_not_empty assigns(:statuses)
  end

  test "only shows the correct user's statuses" do
  	get :show, id: users(:gregory).user_name
  	assigns(:statuses).each do |status|
  		assert_equal users(:gregory), status.user
  end

end
