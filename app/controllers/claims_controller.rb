class ClaimsController < CrudController
  before_action :authorize_manager, only: [:index]

  def index
    claims = Claim.all

    if params[:filter].present? && CategoryFilter.list.keys.include?(params[:filter])
      claims = apply_filter(claims, params[:filter])
    end

    render json: claims
  end

  def create
    claim = ClaimService.create_claim(current_user, claim_params)
    render json: claim, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  private

  def apply_filter(claims, filter)
    case filter
    when "who"
      claims.includes(:user).order("users.name")
    when "when"
      claims.order(date: :desc)
    when "where"
      claims.order(:location)
    when "how_much"
      claims.order(amount: :desc)
    else
      claims
    end
  end

  def authorize_manager
    unless current_user.manager?
      render json: { error: "Acesso negado" }, status: :forbidden
    end
  end

  def claim_params
    params.require(:claim).permit(:description, :amount, :date, :status, receipts: [], tags: [])
  end
end
