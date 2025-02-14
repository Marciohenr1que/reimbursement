# frozen_string_literal: true

module Claims
  class ClaimAttachmentService
    def self.attach_files(claim, receipts)
      return unless receipts.is_a?(Array) && receipts.any?

      claim.receipts.attach(receipts)
    end
  end
end
