FactoryBot.define do
  factory :book do
    title { "title" }
    author { "author" }
    isbn { "23456789" }
    sales_date { "2021年11月12日" }
    item_price { 1990 }
    item_caption { "testtest" }
    publisher_name { "name" }
    # small_image_url { File.open("#{Rails.root"/) }
    small_image_url {"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6466/9784835646466_1_9.jpg?_ex=64x64"}
    medium_image_url {"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6466/9784835646466_1_9.jpg?_ex=120x120"}
    large_image_url {"https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6466/9784835646466_1_9.jpg?_ex=200x200"}
    item_url {"https://books.rakuten.co.jp/rb/16919155/"}
  end
end