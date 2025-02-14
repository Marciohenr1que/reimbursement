class ClaimsController < CrudController
  before_action :authenticate_user!

  def index
    if params[:search].present?
  
      @claims = Claims::ClaimFilterService.new(params.permit(:search)).filter(Claim.all)
    else
      @claims = Claim.includes(:tags).order(created_at: :desc)
    end
  
    @claims = @claims.where(user: current_user) unless current_user.manager?
    @claims = paginate(@claims)
  
    render :index, formats: :json
  end
  
  
  def create
    @claim = Claims::ClaimCreator.call(current_user, claim_params)

    render :create, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def update_claim
    @claim = Claims::ClaimUpdater.call(@claim, claim_params)
  
    render :show, status: :ok, formats: :json
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  
  
  private


  def claim_params
    params.require(:claim).permit(:amount, :description, :status, :date, :location, receipts: [], tags: [])
  end
end








