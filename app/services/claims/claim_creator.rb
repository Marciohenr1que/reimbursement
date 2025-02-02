class Claims::ClaimCreator
  def self.call(user, claim_params)
    raise I18n.t('claims.user_not_found') if user.nil?

    claim = user.claims.build(
      amount: claim_params[:amount].to_f,
      status: claim_params[:status],
      description: claim_params[:description],
      date: claim_params[:date],
      location: claim_params[:location]
    )

    Claims::ClaimAttachmentService.attach_files(claim, claim_params[:receipts])
    Claims::ClaimValidator.validate!(claim)

   
    if claim_params[:tags].present?
      tags = claim_params[:tags].map { |tag_name| Tag.find_or_create_by(name: tag_name.strip) }
      claim.tags = tags 
    end

    claim.save!
    claim
  end
end




