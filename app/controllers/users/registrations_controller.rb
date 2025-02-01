class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name)
  end

  protected

 
  def sign_up(resource_name, resource)
    true
  end
end

