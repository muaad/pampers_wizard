require "whatsapp"
class ReminderWorker
	include Sidekiq::Worker
	sidekiq_options :queue => :reminder, :retry => false

	def perform mother_id, tip_id
		mother = Mother.find(mother_id)
		if !mother.weeks_since_conception.blank?
			tip = Tip.find(tip_id)
			reminder = Reminder.find_or_create_by! tip: tip, mother: mother
			if !reminder.sent
				Whatsapp.send_message(tip.body, mother.phone_number, mother.account)
			end
		end
	end
end