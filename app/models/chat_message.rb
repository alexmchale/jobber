class ChatMessage

  attr_reader :time, :user, :message

  def initialize(time, user, message)
    @time = time.kind_of?(Time) ? time : Time.parse(time)

    @user =
      if user.kind_of?(User)
        user
      elsif !user.blank?
        User.find(user)
      end

    @message = message.to_s
  end

  def encode
    [ time.iso8601, user.andand.id, message ].join("&")
  end

  def self.decode(s)
    (time, user, message) = s.to_s.split("&", 3)

    ChatMessage.new(time, user, message) if time && user && message
  end

end
