class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
  belongs_to :user
  has_one :order

  has_one_attached :image

  validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }

  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_text
    validates :price
  end

  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :status_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :shipping_day_id
  end
end
