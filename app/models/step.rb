class Step < ActiveRecord::Base
  belongs_to :account
  belongs_to :wizard
end
