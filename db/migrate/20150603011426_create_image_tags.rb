class CreateImageTags < ActiveRecord::Migration
  def change
    create_table :image_tags do |t|
      t.integer :tag_id
      t.integer :image_id
      t.timestamps
    end
  end
end
