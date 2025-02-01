# spec/models/claim_spec.rb
require 'rails_helper'

RSpec.describe Claim, type: :model do
  it "is valid with valid attributes" do
    user = create(:user) 
    claim = create(:claim, user: user)
    expect(claim).to be_valid
  end

  it "is not valid without a description" do
    claim = build(:claim, description: nil)
    expect(claim).to_not be_valid
  end

  it "is not valid without an amount" do
    claim = build(:claim, amount: nil)
    expect(claim).to_not be_valid
  end

  it "is not valid without a date" do
    claim = build(:claim, date: nil)
    expect(claim).to_not be_valid
  end

  it "is not valid without a status" do
    claim = build(:claim, status: nil)
    expect(claim).to_not be_valid
  end

  it "has a valid status" do
    claim = create(:claim, status: 1) 
    expect(claim.status).to eq(1)  
  end

  it "is valid with different statuses" do
    expect(build(:claim, status: 0)).to be_valid  
    expect(build(:claim, status: 1)).to be_valid  
    expect(build(:claim, status: 2)).to be_valid  
  end
end
