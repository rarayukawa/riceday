class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :text
      t.string :post_image

      t.timestamps
    end
  end
end
