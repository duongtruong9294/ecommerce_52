require "faker"
FactoryBot.define do
  factory :order1, class: Order do
    association :user
    receiver_name { Faker::Name.name }
    receiver_address { Faker::Address.full_address }
    receiver_phone { Faker::Number.number(10) }
    total_price {Faker::Number.decimal(2)}
    status {0}
  end
  factory :order2, class: Order do
    association :user
    receiver_name { Faker::Name.name }
    receiver_address { Faker::Address.full_address }
    receiver_phone { Faker::Number.number(10) }
    total_price {Faker::Number.decimal(2)}
    status {0}
  end
  factory :order3, class: Order do
    association :user
    receiver_name { Faker::Name.name }
    receiver_address { Faker::Address.full_address }
    receiver_phone { Faker::Number.number(10) }
    total_price {Faker::Number.decimal(2)}
    status {0}
  end
end
