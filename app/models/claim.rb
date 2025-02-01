class Claim < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :status, presence: true
  validates :user, presence: true
  validate :receipt_limit

  has_enumeration_for :status, with: ClaimStatus
  has_many_attached :receipts

  def receipt_limit
    if receipts.count > 2
      errors.add(:receipts, "cannot exceed 2 receipts")
    end
  end
end
