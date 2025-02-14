# frozen_string_literal: true

class ClaimStatus < EnumerateIt::Base
  associate_values(
    pending: 0,
    approved: 1,
    denied: 2
  )
end
