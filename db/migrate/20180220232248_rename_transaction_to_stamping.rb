class RenameTransactionToStamping < ActiveRecord::Migration[5.1]
  def change
    rename_table :transactions, :stampings
  end
end
