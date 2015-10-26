class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :key
      t.text :text
      t.references :question, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true
      t.integer :next_step_id

      t.timestamps null: false
    end
  end
end
