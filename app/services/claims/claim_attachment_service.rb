class Claims::ClaimAttachmentService
  def self.attach_files(claim, receipts)
    return unless receipts.is_a?(Array) && receipts.any?

    claim.receipts.attach(receipts)
  end
end
