class Document < ActiveRecord::Base

  belongs_to :interview

  validates_associated :interview
  validates_presence_of :content

end
