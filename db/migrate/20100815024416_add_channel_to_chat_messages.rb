class AddChannelToChatMessages < ActiveRecord::Migration

  def self.up
    add_column :chat_messages, :channel, :string, :default => "public"
  end

  def self.down
    remove_column :chat_messages, :channel
  end

end
