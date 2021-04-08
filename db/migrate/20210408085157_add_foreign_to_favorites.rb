class AddForeignToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :favorites, :users, column: :user_id
    add_foreign_key :favorites, :posts, column: :post_id
  end
end
