class CreateStamps < ActiveRecord::Migration[5.1]
  def change
    create_table :stamps do |t|
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
