class AddBotCompleteToMother < ActiveRecord::Migration
  def change
    add_column :mothers, :bot_complete, :boolean, default: false
  end
end
