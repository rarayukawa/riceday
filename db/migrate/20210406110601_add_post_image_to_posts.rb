class AddPostImageToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :post_image, :integer
  end
end
