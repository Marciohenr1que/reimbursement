require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is not valid without an email" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with mismatched passwords" do
    user = build(:user, password: "password", password_confirmation: "wrongpassword")
    expect(user).to_not be_valid
  end

  it "is not valid without a role" do
    user = build(:user)
    user.role = nil
    expect(user).to_not be_valid
  end
end