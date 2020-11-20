FactoryBot.define do
  factory :item do
    product {”商品名”}
    description {”商品の説明”}
    category_id {”カテゴリー”}
    condition_id {”商品の状態”}
    price {”販売価格”}
    deliveryfee_id {”配送料の負担”}
    area_id {”発送元の地域”}
    shipping_id {”発送までの日数”}
    
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end