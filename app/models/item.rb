class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user

  belongs_to :category  # 追加部分
  belongs_to :condition  # 追加部分
  belongs_to :deliveryfee  # 追加部分
  belongs_to :area  # 追加部分
  belongs_to :shipping  # 追加部分

  has_one :purchase
  has_one_attached :item_image # アクティブストレージ（拡張子以外のファイル名のみ指定）

# 共通したオプションをまとめる記述
with_options presence: true do
  # 空の投稿を保存できないようにする
      validates :price 
      validates :product
      validates :description
 end

  # プルダウンの選択で「--」の時は保存できないようにする
 with_options numericality: { other_than: 0 }  do
    validates :category_id
    validates :condition_id
    validates :area_id
    validates :deliveryfee_id
    validates :shipping_id
 end
      
  # 半角英数の設定 
      validates :price, format: { with: /\A[a-zA-Z0-9]+\z/, message: "is invalid. Input full-width Half-width alphanumeric."}
  # 入力範囲の設定 
      validates :price, numericality: { only_integer: true, greater_than: 300, less_than: 9999999}
end

