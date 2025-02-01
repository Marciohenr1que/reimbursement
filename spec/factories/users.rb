FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    role { 0 }
    name { Faker::Name.name } 

    trait :manager do
      role { 1 }
    end
  end
end
