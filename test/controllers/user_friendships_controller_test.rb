require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase

  context "#index" do 
    context "when not logged in" do
      should "redirect to the login page" do
        get :index
        assert_response :redirect
      end
    end

    context "when logged in" do
      setup do
        @friendship1 = create(:pending_user_friendship, user: users(:gregory), friend: create(:user, first_name: 'Pending', last_name: 'Friend'))
        @friendship2 = create(:accepted_user_friendship, user: users(:gregory), friend: create(:user, first_name: 'Active', last_name: 'Friend'))

        sign_in users(:gregory)
        get :index
      end

      should "get the index page without error" do
        assert_response :success
      end

      should "assign user_friendship" do
        assert assigns(:user_friendships)
      end

      should "display friend's names" do
        assert_match /Pending/, response.body
      end

      should "display pending information on a pending friendship" do
        assert_select "#user_friendship_#{@friendship1.id}" do
          assert_select "em", "Friendship is pending."
        end
      end
    end
  end

  context "#new" do 
  	context "when not logged in" do
      should "redirect to the login page" do
        get :new
        assert_response :redirect
        assert_redirected_to login_path
      end
    end
    
    context "when logged in" do
    	setup do
    		sign_in users(:gregory)
    	end

    	should "get new and return success" do
    		get :new
    		assert_response :success
    	end

    	should "should set a flash error if the friend_id params is missing" do
    	   get :new, {}
           assert_equal "Friend Required", flash[:error]
    	end

    	should "display the friend's name" do
    		get :new, friend_id: users(:jim)
    		assert_match /#{users(:jim).full_name}/, response.body
    	end

    	should "assign a new user friendship" do
    		get :new, friend_id: users(:jim)
    		assert assigns(:user_friendship)
      end
  	end 							
  end

  context "#accept" do 
    context "when not logged in" do
      should "redirect to the login page" do
        put :accept, id: 1
        assert_response :redirect
        assert_redirected_to login_path
      end
    end
    context "when logged in" do
      setup do
        @friend = create(:user)
        @user_friendship = create(:pending_user_friendship, user: users(:gregory), friend: @friend)
        create(:pending_user_friendship, user: users(:gregory), friend: @friend)
        sign_in users(:gregory)
        put :accept, id: @user_friendship
        @user_friendship.reload
      end

      should "assign a user_friendship" do
        assert assigns(:user_friendship)
        assert_equal @user_friendship, assigns(:user_friendship)
      end

      should "update the state to accepted" do
        assert_equal 'accepted', @user_friendship.state
      end

    end
    context "#edit" do 
      context "when not logged in" do
      should "redirect to the login page" do
      get :edit, id: 1
      assert_response :redirect
      end
    
    end
    
    context "when logged in" do
      setup do
        @user_friendship = create(:pending_user_friendship, user: users(:gregory))
        sign_in users(:gregory)
        get :edit, id: @user_friendship
      end

      should "get edit and return success" do
        assert_response :success
      end

      should "assign to user_friendship" do
        assert assigns(:user_friendship)
      end

      should "assign to friend" do
        assert assigns(:friend)
      end
    end
  end
end
end
