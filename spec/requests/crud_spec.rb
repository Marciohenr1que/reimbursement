# frozen_string_literal: true

require "rails_helper"

RSpec.describe CrudController, type: :request do
  let(:user) { create(:user) }
  let(:resource_class) { Claim }
  let!(:resource) { create(:claim, user: user) }
  let(:valid_attributes) { attributes_for(:claim) }
  let(:invalid_attributes) { {description: nil} }
  let(:headers) { {"Accept" => "application/json"} }

  before do
    sign_in user
    Rails.logger.debug("User signed in: #{user.inspect}")
  end

  describe "GET /index" do
    it "returns a list of resources" do
      get claims_path, headers: headers
      expect(response).to have_http_status(:ok) # Verifica se a resposta é OK (200)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET /show" do
    it "returns a specific resource" do
      get claim_path(resource), headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(resource.id)
    end
  end

  describe "POST /create" do
    context "with valid attributes" do
      it "creates a new resource" do
        expect do
          post claims_path,
            params: {claim: valid_attributes},
            headers: headers
        end.to change(resource_class, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid attributes" do
      it "does not create a new resource" do
        expect do
          post claims_path,
            params: {claim: invalid_attributes},
            headers: headers
        end.not_to change(resource_class, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /update" do
    context "with valid attributes" do
      it "updates the resource" do
        put claim_path(resource),
          params: {claim: valid_attributes},
          headers: headers

        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid attributes" do
      it "does not update the resource" do
        put claim_path(resource),
          params: {claim: invalid_attributes},
          headers: headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "removes the resource" do
      expect do
        delete claim_path(resource), headers: headers
      end.to change(resource_class, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
