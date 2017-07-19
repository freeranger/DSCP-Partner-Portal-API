class ContactNote < ApplicationRecord
  validates :content, presence: true, length: { minimum: 25 }
  validates_presence_of :user
  validates_presence_of :contact

  belongs_to :user
  belongs_to :contact
end
