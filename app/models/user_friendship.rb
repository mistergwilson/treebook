class UserFriendship < ActiveRecord::Base
	belongs_to :user
	#Associates Friend with the User model 
	belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
end
