class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts, through: :post_categories
  has_ancestry

  def self.category_parent_array_create
  category_parent_array = ['---']
  Category.where(ancestry: nil).each do |parent|
    category_parent_array << [parent.name, parent.id]
  end
  return category_parent_array
  end

  def set_posts
  # 親カテゴリーの場合
  if self.root?
    start_id = self.indirects.first.id
    end_id = self.indirects.last.id
    posts = Post.where(category_id: start_id..end_id)
    return posts

    # 子カテゴリーの場合
  elsif self.has_children?
    start_id = self.children.first.id
    end_id = self.children.last.id
    posts = Post.where(category_id: start_id..end_id)
    return posts

    # 孫カテゴリーの場合
  else
    return self.posts
  end
  end
end
