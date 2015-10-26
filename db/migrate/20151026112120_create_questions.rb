class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.references :account, index: true, foreign_key: true
      t.references :step, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
