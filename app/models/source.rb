class Source < ApplicationRecord

  has_one :template,
    class_name: :SourceTemplate

  validates :code,
    presence:   true,
    uniqueness: true,
    length:     { maximum: 16 }

  validates :name,
    presence: true,
    length:   { maximum: 32 }

end
