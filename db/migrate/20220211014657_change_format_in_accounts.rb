class ChangeFormatInAccounts < ActiveRecord::Migration[6.0]
  def change
    change_column :accounts, :balance, :float
  end
end
