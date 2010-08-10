class Interview < ActiveRecord::Base

  has_one :candidate
  accepts_nested_attributes_for :candidate

  has_many :user_interviews
  has_many :users, :through => :user_interviews

  has_many :chat_messages

  belongs_to :current_document, :class_name => "Document"
  has_many :documents

  validates_associated :candidate
  validates_presence_of :starts_at

  before_validation :generate_access_code

  ### AUTHORIZATION ###

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

protected

  def generate_access_code
    self.access_code ||= Digest::SHA1.hexdigest("#{Time.now} -- #{rand}")
  end

end
