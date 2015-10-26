class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :step, index: true, foreign_key: true
      t.text :text
      t.references :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
