class Picture < ApplicationRecord

  belongs_to :property

  validates :property_id,
    presence: true

  validates :url,
    presence:   true,
    uniqueness: { scope: :property_id },
    length:     { maximum: 255 }

end
