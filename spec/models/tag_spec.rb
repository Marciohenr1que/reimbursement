require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "is valid with a name" do
    tag = build(:tag)
    expect(tag).to be_valid
  end

  it "is invalid without a name" do
    tag = build(:tag, name: nil)
    expect(tag).to_not be_valid
  end

  it "is invalid with a non-unique name" do
    create(:tag, name: "transporte")
    tag = build(:tag, name: "transporte")
    expect(tag).to_not be_valid
  end
end
