require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'before_action :authenticate_user!' do
    controller do
      def test_action
        render json: { message: 'Authenticated' }
      end
    end

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      routes.draw do
        get 'test_action' => 'anonymous#test_action'
      end
    end

    context 'when user is authenticated' do
      it 'does not return unauthorized' do
        user = create(:user)
        sign_in user
        
        get :test_action, format: :json
        
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Authenticated')
      end
    end

    context 'when user is not authenticated' do
      it 'returns unauthorized' do
        get :test_action, format: :json
        
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end




