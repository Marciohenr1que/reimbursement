FactoryBot.define do
  factory :claim do
    description { Faker::Lorem.sentence }
    amount { "9.99" }
    date { Faker::Date.backward(days: 14) }
    status { 1 }

    association :user, factory: :user

    after(:build) do |claim|
      claim.receipts.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "receipt.jpg")),
        filename: "receipt.jpg",
        content_type: "image/jpeg"
      )
    end
  end
end

