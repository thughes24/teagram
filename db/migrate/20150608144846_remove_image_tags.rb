class RemoveImageTags < ActiveRecord::Migration
  def change
    drop_table :image_tags
  end
end
