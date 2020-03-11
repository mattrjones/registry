class AddUserIdToGifts < ActiveRecord::Migration[6.0]
  def change
    add_column :gifts, :user_id, :integer
  end
end