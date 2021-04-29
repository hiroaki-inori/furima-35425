class Delivery < ApplicationRecord
  belongs_to :prefecture
  belongs_to :order

  validates :postcode       presence: true
  validates :prefecture_id  numericality: { other_than: 1 }
  validates :city           presence: true
  validates :block          presence: true
  validates :tel            presence: true
end
