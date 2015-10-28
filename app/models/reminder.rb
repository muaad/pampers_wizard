class Reminder < ActiveRecord::Base
  belongs_to :tip
  belongs_to :mother
end
