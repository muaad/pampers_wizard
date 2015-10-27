class Wizard < ActiveRecord::Base
  belongs_to :account
  has_many :steps

  validates_uniqueness_of :start_keyword, scope: :account_id
  validates_uniqueness_of :reset_keyword, scope: :account_id


  def start mother
    first_step = steps.first
    progress = Progress.create! step: first_step, mother: mother

    question = first_step.questions.first

    { progress: progress.id, message: question.to_message(mother) }
  end

  def first_step
    steps.first
  end

  def reset mother
    phone_number = mother.phone_number
    Progress.where(mother_id: mother.id).destroy_all
    mother.delete
    
    text = "Send #{start_keyword} to begin"
    Whatsapp.send_message(text, phone_number, account)
  end

  def self.get_starting_wizards start
    Wizard.where('start_keyword like ? ', start)
  end

  def self.get_reset_wizards reset_keyword
    Wizard.where('reset_keyword like ? ', reset_keyword)
  end
end
