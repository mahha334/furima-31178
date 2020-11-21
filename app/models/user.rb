class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    # ニックネーム・生年月日はオプション必要ないのでこのままの設定。
    validates :nickname, :birthday, presence: true
    # この項目は統一ルールなのでまとめた設定 
    validates :name, :surname, :surnamef, :namef, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}
  end
  has_many :items 
  has_many :purchases
end
