class Claim < ApplicationRecord
  belongs_to :user

  validates :description, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :status, presence: true
  validates :user, presence: true

  has_enumeration_for :status, with: ClaimStatus
end
