class Claim < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :status, presence: true
  validates :user, presence: true

  has_enumeration_for :status, with: ClaimStatus
  has_many_attached :receipts
end
