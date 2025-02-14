# frozen_string_literal: true

require "rails_helper"

RSpec.describe Claims::ClaimValidator, type: :service do
  let(:valid_claim) do
    build(:claim, amount: 100.0,
      receipts: [Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/receipt.jpg"), "image/jpeg")])
  end
  let(:invalid_claim) do
    build(:claim, amount: -1,
      receipts: [Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/receipt.jpg"), "image/jpeg")])
  end

  describe ".validate!" do
    context "when the claim is valid" do
      it "does not raise any error" do
        expect { described_class.validate!(valid_claim) }.not_to raise_error
      end
    end

    context "when the claim amount is invalid" do
      it "raises a validation error" do
        expect { described_class.validate!(invalid_claim) }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when there are more than 2 receipts" do
      let(:invalid_claim_with_multiple_receipts) do
        build(:claim, amount: 100.0, receipts: [
          Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/receipt1.jpg"), "image/jpeg"),
          Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/receipt2.jpg"), "image/jpeg"),
          Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/receipt3.jpg"), "image/jpeg")
        ])
      end

      it "raises a validation error" do
        expect { described_class.validate!(invalid_claim_with_multiple_receipts) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
