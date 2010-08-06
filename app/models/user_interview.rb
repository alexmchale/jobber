class UserInterview < ActiveRecord::Base

  belongs_to :user
  belongs_to :interview

end
