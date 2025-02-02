require 'rails_helper'

RSpec.describe Claims::ClaimAttachmentService, type: :service do
  let(:claim) { build(:claim) }
  let(:receipts) { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/receipt.jpg'), 'image/jpeg')] }

  describe '.attach_files' do
    context 'when receipts are provided' do
      it 'attaches the receipts correctly' do
        described_class.attach_files(claim, receipts)
        expect(claim.receipts.attached?).to be_truthy
      end
    end

    context 'when no receipts are provided' do
      it 'does not attach any files' do
        described_class.attach_files(claim, [])
        expect(claim.receipts.attached?).to be_falsey
      end
    end
  end
end
