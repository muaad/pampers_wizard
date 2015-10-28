class AddUsernameToMother < ActiveRecord::Migration
  def change
    add_column :mothers, :username, :string
  end
end
