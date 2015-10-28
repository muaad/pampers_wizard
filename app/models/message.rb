class Message < ActiveRecord::Base
  belongs_to :chat
  belongs_to :from, :class_name => "Mother"
  belongs_to :to, :class_name => "Mother"
end
