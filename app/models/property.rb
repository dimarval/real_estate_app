class Property < ApplicationRecord

  belongs_to :type,
    class_name: :PropertyType

  belongs_to :operation_type

  belongs_to :price_currency,
    class_name: :Currency,
    optional:   true

  belongs_to :floor_area_unit,
    class_name: :MeasurementUnit,
    optional:   true

  belongs_to :plot_area_unit,
    class_name: :MeasurementUnit,
    optional:   true

  belongs_to :external_agency,
    class_name: :Agency,
    optional:   true

  has_many :pictures,
    -> { order(:id) }

  validates :title,
    presence: true,
    length:   { maximum: 255 }

  validates :description,
    presence: true,
    length:   { maximum: 2048 }

  validates :type_id,
    presence: true

  validates :operation_type_id,
    presence: true

  validates :floor_area,
    numericality: { allow_nil: true }

  validates :floor_area_unit,
    presence: true,
    if:       proc { |advert| advert.floor_area.present? }

  validates :plot_area,
    numericality: { allow_nil: true }

  validates :plot_area_unit,
    presence: true,
    if:       proc { |advert| advert.plot_area.present? }

  validates :rooms,
    numericality: { allow_nil: true }

  validates :bathrooms,
    numericality: { allow_nil: true }

  validates :parking,
    numericality: { allow_nil: true }

  validates :city,
    presence: true,
    length:   { maximum: 255 }

  validates :city_area,
    presence: true,
    length:   { maximum: 255 }

  validates :region,
    presence: true,
    length:   { maximum: 255 }

  validates :price,
    numericality: { allow_nil: true }

  validates :price_currency,
    presence: true,
    if:       proc { |advert| advert.price.present? }

  validates :date,
    presence: true

  validates :published,
    inclusion: { in: [true, false] }

  validates :external_id,
    uniqueness: { scope: :external_agency_id },
    length:     { maximum: 16 }

  validates :external_url,
    length: { maximum: 255 }

end
