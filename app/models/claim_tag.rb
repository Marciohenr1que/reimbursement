class ClaimTag < ApplicationRecord
  belongs_to :claim
  belongs_to :tag
end
