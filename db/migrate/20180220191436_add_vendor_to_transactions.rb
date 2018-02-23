class AddVendorToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :vendor, foreign_key: true, null: false
  end
end
