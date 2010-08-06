class Interview < ActiveRecord::Base

  has_one :candidate
  accepts_nested_attributes_for :candidate

  has_many :user_interviews
  has_many :users, :through => :user_interviews

  validates_associated :candidate
  validates_presence_of :starts_at

end
