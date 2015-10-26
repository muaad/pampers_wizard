class CreateMothers < ActiveRecord::Migration
  def change
    create_table :mothers do |t|
      t.string :name
      t.string :weeks_since_conception
      t.boolean :expectant, default: true
      t.boolean :opted_in, default: true

      t.timestamps null: false
    end
  end
end
