require 'rails_helper'

RSpec.describe Claims::ClaimCreator, type: :service do
  let(:user) { create(:user) }
  let(:claim_params) do
    {
      amount: 100.0,
      status: 0, # pending
      description: 'Descrição do reembolso',
      date: '2025-02-01',
      location: 'São Paulo',
      receipts: [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/files/receipt.jpg'), 'image/jpeg')]
    }
  end

  describe '.call' do
    context 'when user is valid' do
      it 'creates a claim successfully' do
        claim = described_class.call(user, claim_params)

        expect(claim).to be_persisted
        expect(claim.amount).to eq(claim_params[:amount])
        expect(claim.status).to eq(claim_params[:status])
        expect(claim.description).to eq(claim_params[:description])
        expect(claim.receipts.attached?).to be_truthy
      end
    end

    context 'when user is nil' do
      it 'raises an error' do
        expect { described_class.call(nil, claim_params) }.to raise_error('Usuário não encontrado')
      end
    end

    context 'when claim validation fails' do
      let(:invalid_claim_params) { claim_params.merge(amount: -1) }

      it 'raises validation errors' do
        expect { described_class.call(user, invalid_claim_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
