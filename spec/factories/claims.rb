FactoryBot.define do
  factory :claim do
    description { "MyString" }
    amount { "9.99" }
    date { "2025-02-01" }
    status { 1 }

    association :user, factory: :user
  end
end
