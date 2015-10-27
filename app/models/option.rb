class Option < ActiveRecord::Base
  belongs_to :question
  belongs_to :account

	def self.get_valid_option question, text
    question.options.each do |opt|
      if opt.key.downcase == text.downcase || opt.text.downcase == text.downcase
        return opt
      end
    end
    return nil
  end

  def self.is_valid? question, text
    return !get_valid_option(question, text).nil?
  end
end
