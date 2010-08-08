class Template < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :name
  validates_associated :user

end
