require "faker"
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {Faker::Internet.password}
    password_confirmation {password}
    address { Faker::Address.full_address }
    phone { Faker::Number.number(10) }
    confirmed_at {Time.now.utc}
  end
  factory :admin, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {Faker::Internet.password}
    password_confirmation {password}
    address { Faker::Address.full_address }
    phone { Faker::Number.number(10) }
    confirmed_at {Time.now.utc}
  end
  factory :abc, class: User do
    name "duongabc"
    email { Faker::Internet.email }
    password {Faker::Internet.password}
    password_confirmation {password}
    address { Faker::Address.full_address }
    phone { Faker::Number.number(10) }
    confirmed_at {Time.now.utc}
  end
end
