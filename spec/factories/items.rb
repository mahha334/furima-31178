FactoryBot.define do
  factory :item do

    product {Faker::Name.name}  # これ以外はダブっても大丈夫
    description {"商品の説明"}
    category_id {1} # プルダウンなので番号指定（共通の数字）
    condition_id {1}
    price {300}
    deliveryfee_id {1}
    area_id {1}
    shipping_id {1}
    
    association :user
    
    after(:build) do |item|	
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')	
    end

  end
end
