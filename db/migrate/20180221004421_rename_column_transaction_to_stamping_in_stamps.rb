class RenameColumnTransactionToStampingInStamps < ActiveRecord::Migration[5.1]
  def change
    rename_column :stamps, :transaction_id, :stamping_id
  end
end
