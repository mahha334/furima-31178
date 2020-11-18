class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase

  validates :title, presence: true
end
