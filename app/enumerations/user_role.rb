# frozen_string_literal: true

class UserRole < EnumerateIt::Base
  associate_values(
    employee: 0,
    manager: 1
  )
end
