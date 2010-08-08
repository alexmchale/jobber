class CreateChatMessages < ActiveRecord::Migration
  def self.up
    create_table :chat_messages do |t|
      t.references :interview
      t.references :user
      t.text :message

      t.timestamps
    end

    add_index :chat_messages, :interview_id
    add_index :chat_messages, :user_id
  end

  def self.down
    drop_table :chat_messages

    remove_index :chat_messages, :interview_id
    remove_index :chat_messages, :user_id
  end
end
