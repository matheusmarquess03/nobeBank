class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.integer :type, null: false
      t.decimal :value
      t.references :recipient, null: false, foreign_key: { to_table: 'accounts' }
      t.references :sender, null: false, foreign_key: { to_table: 'accounts' }

      t.timestamps
    end
  end
end
