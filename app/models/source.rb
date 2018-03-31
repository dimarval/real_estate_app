class Source < ApplicationRecord

  validates :code,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 16 }

  validates :name,
    presence: true,
    length:   { maximum: 32 }

end
