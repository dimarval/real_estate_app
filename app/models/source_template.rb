class SourceTemplate < ApplicationRecord

  belongs_to :source

  validates :source_id,
    presence: true

  validates :content,
    presence: true

end
