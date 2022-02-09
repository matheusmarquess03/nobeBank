class ChangeColumTypeToKind < ActiveRecord::Migration[6.0]
  def change
    rename_column :transfers, :type, :kind
  end
end
