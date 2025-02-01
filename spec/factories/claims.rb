FactoryBot.define do
  factory :claim do
    description { "MyString" }
    amount { "9.99" }
    date { "2025-02-01" }
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

