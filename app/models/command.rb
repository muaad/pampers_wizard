class Command < ActiveRecord::Base
  belongs_to :step

  def self.spin mother
  	recipient = Mother.where.not(id: mother.id).sample
	if mother.opted_in && !recipient.nil?
		msg = "Here is your random match:\n\n- @#{recipient.username}"
	else
		msg = "Sorry. Remember you are invisible? If people can't see you, it is only fair that you don't see them either, right? You can make yourself visible by sending in /visible/on"
	end
  end
end

