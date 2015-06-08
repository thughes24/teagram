class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :caption
      t.text :images
      t.integer :user_id
      t.timestamps
    end
  end
end
