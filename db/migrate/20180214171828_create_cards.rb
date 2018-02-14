class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.integer :stamps_count
      t.string :name
      t.string :description
      t.boolean :exploited
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
