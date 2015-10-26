class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :name
      t.references :account, index: true, foreign_key: true
      t.references :wizard, index: true, foreign_key: true
      t.integer :next_step_id
      t.string :step_type

      t.timestamps null: false
    end
  end
end
