class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :street
      t.integer :number
      t.integer :postal_code
      t.string :state
      t.string :city
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
