class AddTransactionToStamps < ActiveRecord::Migration[5.1]
  def change
    add_reference :stamps, :transaction, foreign_key: true, null: false
  end
end
