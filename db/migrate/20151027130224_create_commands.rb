class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :name
      t.string :action_path
      t.references :step, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
