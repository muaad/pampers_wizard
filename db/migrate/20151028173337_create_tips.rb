class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :name
      t.text :body
      t.string :week

      t.timestamps null: false
    end
  end
end
