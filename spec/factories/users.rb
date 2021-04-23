FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Lorem.characters(number: 8, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    last_name                 { Gimei.last.kanji }
    first_name                { Gimei.first.kanji }
    last_name_kana            { Gimei.last.katakana }
    first_name_kana           { Gimei.first.katakana }
    birthday                  { '1930-01-01' }
  end
end
