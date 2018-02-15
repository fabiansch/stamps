class AddUserToStamp < ActiveRecord::Migration[5.1]
  def change
    add_reference :stamps, :user, foreign_key: true
  end
end
