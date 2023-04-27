class AddColumnToAccounts < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :mobileno, :string
  end
end
