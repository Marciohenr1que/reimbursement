# frozen_string_literal: true

require "rails_helper"

RSpec.describe Claims::ClaimUpdater, type: :service do
  let(:user) { create(:user) }
  let(:claim) { create(:claim, user: user) }
  let(:claim_params) do
    {
      amount: 150.0,
      status: 1, # approved
      description: "Descrição atualizada",
      date: "2025-02-14",
      location: "Rio de Janeiro",
      receipts: [Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/receipt.jpg"), "image/jpeg")],
      tags: %w[viagem alimentação]
    }
  end

  describe ".call" do
    context "when claim exists" do
      it "updates claim successfully" do
        updated_claim = described_class.call(claim, claim_params)

        expect(updated_claim).to be_persisted
        expect(updated_claim.amount).to eq(claim_params[:amount])
        expect(updated_claim.status).to eq(claim_params[:status])
        expect(updated_claim.description).to eq(claim_params[:description])
        expect(updated_claim.date.to_s).to eq(claim_params[:date])
        expect(updated_claim.location).to eq(claim_params[:location])
        expect(updated_claim.receipts.attached?).to be_truthy
        expect(updated_claim.tags.pluck(:name)).to match_array(claim_params[:tags])
      end
    end

    context "when claim is nil" do
      it "raises an error" do
        expect { described_class.call(nil, claim_params) }
          .to raise_error(I18n.t("claims.user_not_found"))
      end
    end

    context "when claim validation fails" do
      let(:invalid_claim_params) { claim_params.merge(amount: -1) }

      it "raises validation errors" do
        expect { described_class.call(claim, invalid_claim_params) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "when updating tags" do
      it "creates new tags if they dont exist" do
        expect do
          described_class.call(claim, claim_params)
        end.to change(Tag, :count).by(2)
      end

      it "reuses existing tags" do
        Tag.create(name: "viagem")

        expect do
          described_class.call(claim, claim_params)
        end.to change(Tag, :count).by(1)
      end

      it "removes old tags not present in update" do
        old_tag = Tag.create(name: "old_tag")
        claim.tags << old_tag

        updated_claim = described_class.call(claim, claim_params)

        expect(updated_claim.tags.pluck(:name)).not_to include("old_tag")
      end
    end
  end
end
