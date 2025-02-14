# frozen_string_literal: true

require "rails_helper"

RSpec.describe ClaimsController, type: :controller do
  let(:user) { create(:user) }
  let(:manager) { create(:user, role: 1) }
  let(:claim) { create(:claim, user: user) }

  describe "GET #index" do
    context "when the user is a manager" do
      before do
        sign_in(manager)
        get :index
      end

      it "returns status 200" do
        expect(response).to have_http_status(:ok)
      end

      it "returns all claims" do
        expect(assigns(:claims)).to eq([claim])
      end

      context 'with "who" filter' do
        let!(:claim2) { create(:claim, user: create(:user, name: "Zelda")) }

        it 'applies the "who" filter' do
          get :index, params: {filter: "who"}
          expect(response).to have_http_status(:ok)
          expect(assigns(:claims)).to eq([claim2, claim])
        end
      end
    end

    context "when the user is not a manager" do
      before do
        sign_in(user)
        get :index
      end

      it "returns status 403" do
        expect(response).to have_http_status(:forbidden)
      end

      it "does not return the claims" do
        expect(response.body).to include("Access denied")
      end
    end
  end

  describe "POST #create" do
    context "when parameters are correct" do
      before do
        sign_in(user)
        post :create, params: {claim: {description: "New claim", amount: 500, date: Date.today, status: "pending"}}
      end

      it "creates a new claim" do
        expect(Claim.count).to eq(1)
      end

      it "returns status 201" do
        expect(response).to have_http_status(:created)
      end

      it "returns the data of the created claim" do
        expect(response.body).to include("New claim")
      end
    end

    context "when parameters are invalid" do
      before do
        sign_in(user)
        post :create, params: {claim: {description: "", amount: 0, date: nil, status: "invalid"}}
      end

      it "does not create a new claim" do
        expect(Claim.count).to eq(0)
      end

      it "returns status 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the errors" do
        expect(response.body).to include("can't be blank")
      end
    end
  end
end
