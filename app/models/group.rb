class Group < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  has_and_belongs_to_many :contacts
  has_many :links, dependent: :destroy
  has_many :notes, dependent: :destroy
end
