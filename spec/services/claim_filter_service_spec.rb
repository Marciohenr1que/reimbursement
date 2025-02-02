require 'rails_helper'

RSpec.describe Claims::ClaimFilterService, type: :service do
  let!(:claim1) { create(:claim) }
  let!(:claim2) { create(:claim) }

  describe '.filter' do
    context 'when filter is "who"' do
      it 'orders claims by user name' do
        filtered_claims = described_class.filter('who')
        expect(filtered_claims).to eq([claim1, claim2]) 
      end
    end

    context 'when filter is "when"' do
      it 'orders claims by date descending' do
        filtered_claims = described_class.filter('when')
        expect(filtered_claims).to eq([claim2, claim1])
      end
    end

    context 'when filter is "where"' do
      it 'orders claims by location' do
        filtered_claims = described_class.filter('where')
        expect(filtered_claims).to eq([claim2, claim1])
      end
    end

    context 'when filter is "how_much"' do
      it 'orders claims by amount descending' do
        filtered_claims = described_class.filter('how_much')
        expect(filtered_claims).to eq([claim2, claim1])
      end
    end

    context 'when filter is unknown' do
      it 'returns all claims' do
        filtered_claims = described_class.filter('unknown')
        expect(filtered_claims).to eq([claim1, claim2])
      end
    end
  end
end
