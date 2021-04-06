class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories

  def self.category_parent_array_create
  category_parent_array = ['---']
  Category.where(ancestry: nil).each do |parent|
    category_parent_array << [parent.name, parent.id]
  end
  return category_parent_array
  end
end
