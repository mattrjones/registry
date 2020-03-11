class CreateGifts < ActiveRecord::Migration[6.0]
  def change
    create_table :gifts do |t| 
      t.string :content 
    end 
  end
end
