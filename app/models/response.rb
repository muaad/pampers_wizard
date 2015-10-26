class Response < ActiveRecord::Base
  belongs_to :step
  belongs_to :account
end
