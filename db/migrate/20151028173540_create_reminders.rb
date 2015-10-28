class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.references :tip, index: true, foreign_key: true
      t.references :mother, index: true, foreign_key: true
      t.boolean :sent, default: false

      t.timestamps null: false
    end
  end
end
