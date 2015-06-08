class UpdateImages < ActiveRecord::Migration
  def change
    rename_column :images, :images, :image
  end
end
