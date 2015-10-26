class AddPhoneNumberToMother < ActiveRecord::Migration
  def change
    add_column :mothers, :phone_number, :string
  end
end
