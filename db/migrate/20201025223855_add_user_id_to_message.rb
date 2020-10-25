class AddUserIdToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :user, foreign_key: true, null: false
  end
end
