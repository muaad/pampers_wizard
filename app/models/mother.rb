class Mother < ActiveRecord::Base
	belongs_to :account
	has_many :chats
	has_many :progresses
	has_many :friends, :through => :chats

	def chats
		Chat.where("mother_id = ? OR friend_id = ?", id, id)
	end

	def chats_with mother
		chats.where("mother_id = ? OR friend_id = ?", mother.id, mother.id)
	end

	def last_chat
		chats.order("updated_at desc").first
	end

	def active_chats
		chats.active
	end

	def in_chat?
		!username.nil? && !chats.empty? && progresses.blank?
	end

	def self.check_format message
		pattern = /^(?=.*\D)[-\w]+$/
		error = ""
		# Needs to be one word, cannot include anything except - and _, cannot be a number. Must also be unique
		if username_exists?(message)
			error = "The username you have chosen, #{message}, already exists. Please choose another."
		elsif (pattern =~ message).nil?
			if message.split(" ").length > 1
				error = "No spaces please. Usernames should be all one word. And, try to make it short, too, so, it will be easy for people to find you."
			elsif is_number?(message)
				error = "You sent #{message}. Usernames cannot be a number. It should be made up of letters or a combination of letters and digits."
			else
				error = "You sent #{message}. Your username can only contain letters, numbers or one of - and _"
			end
		end
		error
	end

	def self.is_number?(object)
	  true if Float(object) rescue false
	end

	def buddies
		buds = []
		chats.each do |chat|
			recipient = chat.recipient(self)
			if !recipient.nil?
				buds << "@#{recipient.username}"
			end
		end
		buds
	end

	def self.username_exists? username
		!Mother.where("username like '#{username}'").empty?
	end
end
