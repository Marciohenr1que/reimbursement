class Claims::ClaimFilterService
  def initialize(params)
    @params = params.to_h.symbolize_keys.compact
  end

  def filter(scope)
    return scope unless @params[:search].present?

    search_value = "%#{sanitize_search_term(@params[:search])}%".downcase

    scope
      .left_joins(:user, :claim_tags, :tags) 
      .where(search_conditions, search: search_value)
      .distinct
  end

  private

  def search_conditions
    @search_conditions ||= [
      'LOWER(claims.description) LIKE :search',
      'LOWER(users.name) LIKE :search',
      'LOWER(tags.name) LIKE :search'
    ].join(' OR ')
  end

  def sanitize_search_term(term)
    term.gsub(/[%_\\]/) { |char| "\\#{char}" }
  end
end


