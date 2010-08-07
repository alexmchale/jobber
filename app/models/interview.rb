class Interview < ActiveRecord::Base

  has_one :candidate
  accepts_nested_attributes_for :candidate

  has_many :user_interviews
  has_many :users, :through => :user_interviews

  validates_associated :candidate
  validates_presence_of :starts_at

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

  ### CHAT ###

  def chat_key
    "interview:#{id}:chat"
  end

  def chats(offset = 0)
    chats = redis.lrange(chat_key, offset, -1) || []

    chats.map do |chat_string|
      ChatMessage.decode chat_string
    end
  end

  def append_chat(user, message)
    cm = ChatMessage.new(Time.now, user, message)

    redis.lpush chat_key, cm.encode
  end

end
