class Tag < ApplicationRecord
  has_many :claim_tags, dependent: :destroy
  has_many :claims, through: :claim_tags
end
