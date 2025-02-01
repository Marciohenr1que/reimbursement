class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  
  def respond_with(resource, _opts = {})
    if resource.nil?
      render 'users/sessions/error', status: :unauthorized
    else
      
      render 'users/sessions/login', status: :ok
    end
  end

  def respond_to_on_destroy
    head :no_content
  end

  
  def authenticate_user!
    user = User.find_by(email: params[:user][:email])

    if user.nil? || !user.valid_password?(params[:user][:password])
     
      render 'users/sessions/error', status: :unauthorized
    else
      super
    end
  end
end
