class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :chat, index: true, foreign_key: true
      t.text :body
      t.references :from, index: true, foreign_key: true
      t.references :to, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
