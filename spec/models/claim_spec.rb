require 'rails_helper'

RSpec.describe Claim, type: :model do
  let(:user) { create(:user) }
  let(:claim) { create(:claim, user: user) }

  it "is valid with valid attributes" do
    expect(claim).to be_valid
  end

  it "is not valid without a description" do
    claim.description = nil
    expect(claim).to_not be_valid
  end

  it "is not valid without an amount" do
    claim.amount = nil
    expect(claim).to_not be_valid
  end

  it "is not valid without a date" do
    claim.date = nil
    expect(claim).to_not be_valid
  end

  it "is not valid without a status" do
    claim.status = nil
    expect(claim).to_not be_valid
  end

  it "has a valid status" do
    expect(claim.status).to eq(1)
  end

  it "is valid with different statuses" do
    expect(build(:claim, status: 0)).to be_valid  
    expect(build(:claim, status: 1)).to be_valid  
    expect(build(:claim, status: 2)).to be_valid  
  end

  it "can have attached receipts" do
    expect(claim.receipts).to be_attached
  end
end
