# frozen_string_literal: true

module Claims
  class ClaimValidator
    def self.validate!(claim)
      if claim.amount.nil? || claim.amount <= 0
        raise ActiveRecord::RecordInvalid.new(claim), I18n.t("claims.validation.amount_invalid")
      end

      unless claim.receipts.attached?
        raise ActiveRecord::RecordInvalid.new(claim), I18n.t("claims.validation.receipt_required")
      end

      return unless claim.receipts.count > 2

      raise ActiveRecord::RecordInvalid.new(claim), I18n.t("claims.validation.receipt_limit_exceeded")
    end
  end
end
