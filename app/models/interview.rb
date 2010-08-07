class Interview < ActiveRecord::Base

  has_one :candidate
  accepts_nested_attributes_for :candidate

  has_many :user_interviews
  has_many :users, :through => :user_interviews

  validates_associated :candidate
  validates_presence_of :starts_at

  # Token can be a user or an access code.
  def authorized?(token)
    case token
    when User
      self.users.include? token
    when String
      self.access_code == token
    else
      false
    end
  end

end
