class OperationType < ApplicationRecord

  validates :code,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 32 }

end
