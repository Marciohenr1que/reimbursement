class Claim < ApplicationRecord
  belongs_to :user
  has_many_attached :receipts
  has_many :claim_tags, dependent: :destroy
  has_many :tags, through: :claim_tags
  validates :amount, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ClaimStatus.list }
  validate :validate_receipts_count

  scope :filtered, ->(filter) {
    case filter.to_sym
    when :who then includes(:user).order("users.name")
    when :when then order(date: :desc)
    when :where then order(:location)
    when :how_much then order(amount: :desc)
    else all
    end
  }

  private

  def validate_receipts_count
    errors.add(:receipts, "Não é permitido mais de 2 comprovantes") if receipts.attached? && receipts.count > 2
  end
end

