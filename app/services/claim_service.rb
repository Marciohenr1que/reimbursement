class ClaimService
  # Responsável por criar um novo reembolso
  def self.create_claim(user, claim_params)
    claim = user.claims.build(claim_params)

    # Validando o reembolso
    validate_claim(claim)

    # Salvar o reembolso
    claim.save!
    claim
  end

  # Validação adicional para regras de negócios
  def self.validate_claim(claim)
    # A quantidade deve ser positiva
    if claim.amount <= 0
      raise ActiveRecord::RecordInvalid.new(claim), "O valor do reembolso deve ser maior que zero"
    end

    if claim.receipts.attached? && claim.receipts.count > 2
      raise ActiveRecord::RecordInvalid.new(claim), "Não é permitido mais de 2 comprovantes"
    end

    true
  end

  # Autoriza o gerente a acessar as reivindicações
  def self.authorize_manager(user)
    raise 'Access denied' unless user.manager?
  end
  

  # Filtra as reivindicações por categoria
  def self.filter_claims_by_category(filter)
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

