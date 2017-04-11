class Link < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
  validates :destination, presence: true, length: { minimum: 12, maximum: 256 }, :url => true

  belongs_to :group
end
