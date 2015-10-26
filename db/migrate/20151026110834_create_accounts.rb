class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :phone_number
      t.string :auth_token
      t.string :name

      t.timestamps null: false
    end
  end
end
