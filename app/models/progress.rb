class Progress < ActiveRecord::Base
  belongs_to :mother
  belongs_to :step
end
