class ApplicationController < ActionController::API
  before_action :authenticate_user!
  
  respond_to :json
  
  private
  
  def authenticate_user!
    if request.format.json?
      unless current_user
        render json: { error: 'Unauthorized' }, status: :unauthorized
        return
      end
    else
      super
    end
  end
end