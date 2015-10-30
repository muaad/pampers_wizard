require "whatsapp"
class Chat < ActiveRecord::Base
  belongs_to :mother
  belongs_to :friend, :class_name => "Mother"

  scope :active, -> { where(active: true) }

  def recipient sender
  	receiver = nil
  	if mother == sender
  		receiver = friend
  	else
  		receiver = mother
  	end
  	receiver
  end

  def self.process sender, username="", message
  	account = sender.account
  	sender.progresses.delete_all if !sender.progresses.blank?
  	if !username.empty?
  		recipient = Mother.where('username ilike ?', username).first
  		if !recipient.nil?
  			if recipient.opted_in && sender.opted_in
  				chats = sender.chats_with(recipient)
  				if chats.empty?
  					sender.chats.update_all(active: false)
  					recipient.chats.update_all(active: false)
  					chat = Chat.find_or_create_by(mother_id: sender.id, friend_id: recipient.id)
            chat.update(active: true)
  					Message.create! chat: chat, body: message, from_id: sender.id, to_id: recipient.id
  				else
  					sender.chats.update_all(active: false)
  					recipient.chats.update_all(active: false)
  					chat = chats.first
  					chat.active = true
  					chat.save!
  					Message.create! chat: chat, body: message, from_id: sender.id, to_id: recipient.id
  				end
  				Whatsapp.send_message "@#{sender.username} says:\n\n#{message}", recipient.phone_number, account
  			else
  				if !recipient.opted_in
  					Whatsapp.send_message "@#{recipient.username} has chosen to be invisible. You won't be able to chat with her unless she is visible.", sender.phone_number, account
  				elsif !sender.opted_in
  					Whatsapp.send_message "Hey @#{sender.username}, Remember you are invisible? If you want to be able to chat with people, make yourself visible by sending in /visible/on", sender.phone_number, account
  				end
  			end
  		else
  			Whatsapp.send_message "There is no user with the username @#{username}. Send /spin to get someone to talk to or /friends to get a list of the people you have chat with.", sender.phone_number, account
  		end
  	else
  		active = sender.active_chats.first
  		last_chat = sender.last_chat
  		chat = active.nil?? last_chat : active
  		if !chat.nil?
  			recipient = chat.recipient(sender)
  			if recipient.opted_in && sender.opted_in
  				if !active.nil?
  					Whatsapp.send_message "@#{sender.username} says:\n\n#{message}", recipient.phone_number, account
  					Message.create! chat: chat, body: message, from_id: sender.id, to_id: recipient.id
  				else
  					Whatsapp.send_message "@#{sender.username} says:\n\n#{message}\n\nYou don't have an active chat with @#{sender.username}. To reply to @#{sender.username}, start your message with @#{sender.username}.", recipient.phone_number, account
  					Message.create! chat: sender.last_chat, body: message, from_id: sender.id, to_id: recipient.id
  					Whatsapp.send_message "Your last active chat was with @#{recipient.username} who has since started another chat with someone else. Don't worry. We have delivered your message to @#{recipient.username}. You can start your message with @#{recipient.username} just to be safe.", sender.phone_number, account
  				end
  			else
  				if !recipient.opted_in
  					Whatsapp.send_message "@#{recipient.username} has chosen to be invisible. You won't be able to chat with her unless she is visible.", sender.phone_number, account
  				elsif !sender.opted_in
  					Whatsapp.send_message "Hey @#{sender.username}, Remember you are invisible? If you want to be able to chat with people, make yourself visible by sending in /visible/on", sender.phone_number, account
  				end
  			end
  		else
  			Whatsapp.send_message "You are currently not chatting with anyone. Send /spin to find a random person to talk to. You can also search by gender. To find some help on how to chat on here, send /help/chat.", sender.phone_number, account
  		end
  	end
  end

  def self.message_details message
  	msg = ""
  	username = ""
  	if message.include?(":") && message.split(":")[0].split(" ").length <= 2
  		username = message.split(":")[0].gsub("@", "").strip
  		msg = message.split(":")[1..message.length].join(" ")
  	else
  		username = message.split(" ")[0].gsub("@", "")
  		msg = message.split(" ")[1..message.length].join(" ")
  	end
  	{message: msg, username: username}
  end
end
