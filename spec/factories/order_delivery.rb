FactoryBot.define do
  factory :order_delivery do
    postcode { '123-4567' }
    prefecture_id { 2 }
    city { '大阪市' }
    block { '1-1-1' }
    building { '東京ハイツ' }
    tel { '09012345678' }
  end
end