class ActiveRecord::Base

  def redis
    $redis or raise("redis is not configured")
  end

end
