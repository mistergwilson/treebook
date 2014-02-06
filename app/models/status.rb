class Status < ActiveRecord::Base
  
    validates :user, presence: true

    validates :content, presence: true, length: {minimum: 2}

	belongs_to :user
end
