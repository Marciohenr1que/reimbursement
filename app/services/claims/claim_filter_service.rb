class Claims::ClaimFilterService
  def self.filter(filter)
    case filter
    when "who"
      Claim.includes(:user).order("users.name")
    when "when"
      Claim.order(date: :desc)
    when "where"
      Claim.order(:location)
    when "how_much"
      Claim.order(amount: :desc)
    else
      Claim.all
    end
  end
end
