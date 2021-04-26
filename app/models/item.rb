class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
  belongs_to :user
  has_one :buy

  has_one_attached :image

  validates :image,               presence: true
  validates :item_name,           presence: true
  validates :item_text,           presence: true
  validates :category_id,         numericality: { other_than: 1 }
  validates :status_id,           numericality: { other_than: 1 }
  validates :delivery_charge_id,  numericality: { other_than: 1 }
  validates :prefecture_id,       numericality: { other_than: 1 }
  validates :shipping_day_id,     numericality: { other_than: 1 }
  validates :price,               presence: true, numericality: { only_integer: true, greater_than: 300, less_than: 9_999_999 }
end
