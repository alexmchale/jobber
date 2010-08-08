class User < ActiveRecord::Base

  include Clearance::User

  has_many :user_interviews
  has_many :interviews, :through => :user_interviews
  has_many :templates

end
