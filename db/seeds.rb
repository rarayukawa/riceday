# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#既製品
readymade = Category.create(name: '既製品')
readymade_children_array = ['市販', 'お取り寄せ']
readymade_grandchildren_array = [
  ['肉', '魚', '野菜', 'その他'], # 市販の子
  ['肉', '魚', '野菜', 'その他']
  ]

readymade_children_array.each_with_index do |children, index|
  children = readymade.children.create(name: children)
 readymade_grandchildren_array[index].each do |grandchildren|
    children.children.create(name: grandchildren)
  end
end


#レシピ
recipe = Category.create(name: 'レシピ')
recipe_children_array = ['肉', '魚', '野菜', 'スープ', 'その他']
recipe_grandchildren_array = [
  ['~5分', '~10分', '~30分', '~1時間','それ以上'],
  ['~5分', '~10分', '~30分', '~1時間','それ以上'],
  ['~5分', '~10分', '~30分', '~1時間','それ以上'],
  ['~5分', '~10分', '~30分', '~1時間','それ以上'],
  ['~5分', '~10分', '~30分', '~1時間','それ以上']
]

recipe_children_array.each_with_index do |children, index|
  children = recipe.children.create(name: children)
  recipe_grandchildren_array[index].each do |grandchildren|
    children.children.create(name: grandchildren)
  end
end