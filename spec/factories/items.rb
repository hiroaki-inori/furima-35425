FactoryBot.define do
  factory :item do
    item_name            { Faker::Name.initials(number: 40) }
    item_text            { Faker::Lorem.characters(number: 100) }
    category_id          { Faker::Number.between(from: 2, to: 10) }
    status_id            { Faker::Number.between(from: 2, to: 7) }
    delivery_charge_id   { Faker::Number.between(from: 2, to: 3) }
    prefecture_id        { Faker::Number.between(from: 2, to: 47) }
    shipping_day_id      { Faker::Number.between(from: 2, to: 4) }
    price                { 500 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
