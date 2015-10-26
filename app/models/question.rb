class Question < ActiveRecord::Base
  belongs_to :account
  belongs_to :step
end
