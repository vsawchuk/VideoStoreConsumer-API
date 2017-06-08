class AddImageToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :image_url, :string
  end
end
