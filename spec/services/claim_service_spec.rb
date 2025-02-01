require 'rails_helper'

RSpec.describe ClaimService do
  let(:user) { create(:user) }
  let(:valid_params) { attributes_for(:claim) }

  describe '.create_claim' do
    context 'with valid data' do
      it 'creates a claim' do
        claim = described_class.create_claim(user, valid_params)
        expect(claim).to be_persisted
      end
    end

    context 'with invalid data' do
      it 'rejects negative amount' do
        expect {
          described_class.create_claim(user, valid_params.merge(amount: -10))
        }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'rejects too many receipts' do
        claim = build(:claim, user: user)
        3.times do
          claim.receipts.attach(
            io: File.open(Rails.root.join('spec/fixtures/files/receipt.jpg')),
            filename: 'receipt.jpg'
          )
        end
        expect {
          described_class.validate_claim(claim)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe '.filter_claims_by_category' do
    it 'correctly filters by category' do
      create_list(:claim, 3)
      expect(described_class.filter_claims_by_category('how_much').count).to eq(3)
    end
  end
end

