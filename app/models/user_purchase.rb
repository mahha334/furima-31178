class  UserPurchase # 手順1.

 include ActiveModel::Model # 手順2.

 # 手順3.保存したい複数のテーブルのカラム名全て
  attr_accessor :postcd, :city, :area_id, :addressb, :building, :phone, :purchase, :user_id, :item_id, :token
  
 # 手順4. 配送のバリデーションの処理
 # 共通したオプションをまとめる記述
 with_options presence: true do
  # 空の投稿を保存できないようにする
      validates :postcd
      validates :city
      validates :area_id
      validates :addressb
      validates :phone
      validates :user_id  # 追加部分
      validates :item_id  # 追加部分
      validates :token  # 追加部分
    end
 # プルダウン（商品の地域＝都道府県）の選択で「--」の時は保存できないようにする
      validates :area_id, numericality: { other_than: 0 }
 # 「〒」の郵便番号に関するバリデーション
      validates :postcd, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
 # 「市区町村」の郵便番号に関するバリデーション
      validates :city, format: {with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}
 # 「電話」の郵便番号に関するバリデーション
      validates :phone, format: {with: /\A[0-9]{11}\z/, message: "is invalid. Include nothyphen & <= 11"}
      

  def save  # 手順5. データを保存する処理を書く（ER図設計に基づいて記述順番を考える事必須）
    # 購入の情報を保存
    kounyu = Purchase.create(user_id: user_id, item_id: item_id)  # これだけでは空でも保存できてしまう。
    # 配送先の情報を保存
    Delivery.create(postcd: postcd, city: city, area_id: area_id, addressb: addressb, building: building, phone: phone, purchase_id: kounyu.id)
    
  end
end