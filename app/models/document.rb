class Document < ActiveRecord::Base

  belongs_to :interview

  validates_associated :interview

end
