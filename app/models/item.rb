class Item < ApplicationRecord

  validates :item_name,           presence: true
  validates :item_text,           presence: true
  validates :category_id,         presence: true
  validates :status_id,           presence: true
  validates :delivery_charge_id,  presence: true
  validates :prefecture_id,       presence: true
  validates :shipping_day_id,     presence: true
  validates :price,               presence: true
  
  has_one_attached :image

  belongs_to :user
  has_one :buy
end
