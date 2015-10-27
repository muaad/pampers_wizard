class Question < ActiveRecord::Base
  belongs_to :account
  belongs_to :step
  has_many :options

  def personalize mother
  	text.gsub(/{{mother_name}}/, mother.name.blank? ? "" : mother.name)
  end

  def to_result mother
    if step.step_type == "menu"
      q = "#{personalize(mother)}\n#{options_text}"
    else
      q = personalize(mother)
    end
  	{ type: "Question", text: q, phone_number: mother.phone_number }
  end

  def options_text
    options.order(key: :asc).collect { |opt| "#{opt.key}. #{opt.text}" }.join("\r\n")    
  end

  def to_message mother
    personalize(mother)
  end
end
