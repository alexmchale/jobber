class ActiveRecord::Base

  def redis
    @redis ||= Redis.new
  end

end
