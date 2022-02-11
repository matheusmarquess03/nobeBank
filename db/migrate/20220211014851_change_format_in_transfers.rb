class ChangeFormatInTransfers < ActiveRecord::Migration[6.0]
  def change
    change_column :transfers, :value, :float
  end
end
