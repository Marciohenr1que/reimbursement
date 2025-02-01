class ClaimsController < CrudController
  before_action :authorize_manager, only: [:index]

  def index
    claims = ClaimService.filter_claims_by_category(params[:filter])
    render json: claims
  end

  def create
    claim = ClaimService.create_claim(current_user, claim_params)
    render json: claim, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def authorize_manager
    unless current_user.manager?
      render json: { error: "Acesso negado" }, status: :forbidden
    end
  end

  def claim_params
    params.require(:claim).permit(:description, :amount, :date, :status, receipts: [], tags: [])
  end
end
