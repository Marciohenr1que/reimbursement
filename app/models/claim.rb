class Claim < ApplicationRecord
  belongs_to :user
  has_many_attached :receipts
  has_many :claim_tags, dependent: :destroy
  has_many :tags, through: :claim_tags
  validates :amount, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ClaimStatus.list }
end

