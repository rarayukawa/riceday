# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#既製品

#既製品子カテゴリー配列
readymade_child_array = ['市販','お取り寄せ']
#既製品孫カテゴリー配列
readymade_grandchild_array = [['肉','魚','野菜'], ['肉','魚','野菜']]
parent = Category.create(name: '既製品')
readymade_child_array.each_with_index do |child, i|
 child = parent.children.create(name: child)
 readymade_grandchild_array[i].each do |grandchild|
   child.children.create(name: grandchild)
 end
end

#レシピ

#レシピ子カテゴリー配列
recipe_child_array = ['肉','野菜','魚','スープ','その他']
#レシピ孫カテゴリー配列
recipe_grandchild_array = [['~5分', '~10分', '~30分', '1時間~'], ['~5分', '~10分', '~30分', '1時間~'], ['~5分', '~10分', '~30分', '1時間~'], ['~5分', '~10分', '~30分', '1時間~'], ['~5分', '~10分', '~30分', '1時間~']]
parent = Category.create(name: 'レシピ')
recipe_child_array.each_with_index do |child, i|
 child = parent.children.create(name: child)
 recipe_grandchild_array[i].each do |grandchild|
   child.children.create(name: grandchild)
 end
end