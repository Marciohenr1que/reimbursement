class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = request.env['warden-jwt_auth.token']

    render json: {
      message: "Login realizado com sucesso",
      user: resource,
      token: token
    }, status: :ok
  end

  def respond_to_on_destroy
    head :no_content
  end
end

