class ChangeDataTypeForWeekInTip < ActiveRecord::Migration
  def change
  	change_column :tips, :week, :integer
  end
end
