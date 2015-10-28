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
end
