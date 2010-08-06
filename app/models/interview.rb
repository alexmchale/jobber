class Interview < ActiveRecord::Base

  has_one :candidate

  validates_associated :candidate
  validates_presence_of :starts_at

end
