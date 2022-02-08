class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance
      t.integer :account_number, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
