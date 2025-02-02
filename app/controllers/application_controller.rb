class ApplicationController < ActionController::API
  respond_to :json
  
  private
  
  def authenticate_user!
    token = extract_token_from_header
    
    if token
      begin
        # Usando a mesma chave que usamos para gerar o token
        decoded = JWT.decode(
          token, 
          Rails.application.secret_key_base,
          true, 
          { algorithm: 'HS256' }
        )
        
        payload = decoded.first
        @current_user = User.find(payload['sub'])
      rescue JWT::DecodeError => e
        Rails.logger.error "Erro ao decodificar token: #{e.message}"
        render json: { error: 'Token inválido' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.error "Usuário não encontrado: #{e.message}"
        render json: { error: 'Usuário não encontrado' }, status: :unauthorized
      end
    else
      render json: { error: 'Token não fornecido' }, status: :unauthorized
    end
  end
  
  def current_user
    @current_user
  end
  
  def extract_token_from_header
    header = request.headers['Authorization']
    header&.split(' ')&.last
  end
end