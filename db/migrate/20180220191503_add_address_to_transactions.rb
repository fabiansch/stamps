class AddAddressToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :address, foreign_key: true, null: false
  end
end
