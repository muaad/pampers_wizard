class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :mother, index: true, foreign_key: true
      t.integer :friend_id
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
