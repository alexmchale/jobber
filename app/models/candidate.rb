class Candidate < ActiveRecord::Base

  belongs_to :interview

  validates_presence_of :name
  validates_presence_of :email

end
