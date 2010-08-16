class ChatMessage < ActiveRecord::Base

  belongs_to :interview
  belongs_to :user

  validates_associated :interview
  validates_presence_of :message
  validates_inclusion_of :channel, :in => %w( public private )

end
