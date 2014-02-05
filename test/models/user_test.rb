require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
   test "a user should enter a first name" do
   		user = User.new
   		assert !user.save
   		assert !user.errors[:first_name].empty?
   	end

   	test "a user should enter a last name" do
   		user = User.new
   		assert !user.save
   		assert !user.errors[:last_name].empty?
   	end

   	test "a user should enter a user name" do
   		user = User.new
   		assert !user.save
   		assert !user.errors[:user_name].empty?
   	end

   	test "a user should have a unique profile name" do
   		user = User.new
   		user.user_name = users(:gregory).user_name

   		#don't save user to database
   		assert !user.save
   		#view log
   		puts user.errors.inspect
   		assert !user.errors[:user_name].empty?
   	end

   	test "a user should have a user name without spaces" do
   		user = User.new
   		user.user_name = "My profile with spaces"

   		assert !user.save
   		assert !user.errors[:user_name].empty?
   		assert user.errors[:user_name].include?("Please use only letters, numbers, underscores, or dashes in username.")
   	end
end
