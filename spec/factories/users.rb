FactoryBot.define do
  factory :user do
    email { "xxmarcio@gmail.com" }
    password { "123456" }
    password_confirmation { "123456" }
    role { UserRole::EMPLOYEE }
  end
end