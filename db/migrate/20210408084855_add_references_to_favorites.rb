class AddReferencesToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :favorites, :user
    add_foreign_key :favorites, :post
  end
end
