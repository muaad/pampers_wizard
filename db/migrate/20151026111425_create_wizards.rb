class CreateWizards < ActiveRecord::Migration
  def change
    create_table :wizards do |t|
      t.string :start_keyword
      t.references :account, index: true, foreign_key: true
      t.string :name
      t.string :reset_keyword

      t.timestamps null: false
    end
  end
end
