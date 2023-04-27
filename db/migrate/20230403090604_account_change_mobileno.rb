class AccountChangeMobileno < ActiveRecord::Migration[6.1]
  def change
    change_column(:accounts, :mobileno, :integer)
  end
end
