class Mother < ActiveRecord::Base
	belongs_to :account
	has_many :chats
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
