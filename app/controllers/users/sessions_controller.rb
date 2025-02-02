class Users::SessionsController < Devise::SessionsController
  respond_to :json
  
  private
  
  def respond_with(resource, _opts = {})
    if resource.nil?
      render 'users/sessions/error', status: :unauthorized
    else
      @user = resource
      @token = generate_jwt_token(resource)
      render json: {
        message: I18n.t('users.sessions.create.login_success'),
        user: @user.as_json(only: [:id, :email, :created_at, :updated_at, :role, :name]),
        token: @token
      }, status: :ok
    end
  end

  def respond_to_on_destroy
    head :no_content
  end

  def authenticate_user!
    user = User.find_by(email: params[:user][:email])
    
    if user.nil? || !user.valid_password?(params[:user][:password])
     
      render json: { error: I18n.t('users.sessions.login_error') }, status: :unauthorized
    else
      super
    end
  end

  private

  def generate_jwt_token(user)
    JWT.encode(
      {
        sub: user.id,
        scp: 'user',
        aud: nil,
        iat: Time.now.to_i,
        exp: 1.hour.from_now.to_i,
        jti: SecureRandom.uuid
      },
      Rails.application.secret_key_base,
      'HS256'
    )
  end
end
