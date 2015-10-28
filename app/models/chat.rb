class Chat < ActiveRecord::Base
  belongs_to :mother
  belongs_to :friend
end
