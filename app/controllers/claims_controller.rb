class ClaimsController < CrudController
  before_action :authorize_manager, only: [:index]
  before_action :authenticate_user!, only: [:create]

  def create
    @claim = Claims::ClaimCreator.call(current_user, claim_params)

    render :create, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def claim_params
    params.require(:claim).permit(:amount, :description, :status, :date, :location, receipts: [], tags: [])
  end
end








