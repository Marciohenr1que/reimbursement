# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :name)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :name)
    end

    protected

    def sign_up(_resource_name, _resource)
      true
    end
  end
end
