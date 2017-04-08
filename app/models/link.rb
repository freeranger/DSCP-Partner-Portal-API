class Link < ApplicationRecord
  validates :title, presence: true
  validates :destination, presence: true

  belongs_to :group
end
