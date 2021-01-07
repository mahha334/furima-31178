class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
  
# 共通したオプションをまとめる記述
with_options presence: true do
  # ニックネーム・生年月日はオプション必要ないのでこのままの設定。
      validates :nickname, :birthday, presence: true
  # 全角ひらがな、全角カタカナ、漢字でまとめた設定 
      validates :name, :surname, :surnamef, :namef, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters."}
  # 姓（カナ）、名（カナ）はカタカナしか登録できない設定 
      validates :surnamef, :namef, format: { with: /\A[ァ-ヶー－]+\z/, message: "is invalid. Input full-width katakana characters."}
    end

  has_many :items 
  has_many :purchases
end
