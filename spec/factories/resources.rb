FactoryBot.define do
  factory :resource do
    name { "Test Resource" }
    description { "This is a test description." }
    status { "active" }
  end
end