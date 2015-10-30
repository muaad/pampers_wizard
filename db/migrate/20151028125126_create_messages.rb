class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :chat, index: true, foreign_key: true
      t.text :body
      t.integer :from_id
      t.integer :to_id

      t.timestamps null: false
    end
  end
end
