class OrderDelivery
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :block, :building, :tel, :user_id, :item_id

  with_options presence: true do
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :tel,      format: {with: /\A\d{11}\z/, message: "is invalid."}
    validates :user_id
    validates :item_id
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivery.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, tel: tel, order_id: order.id)
  end
end