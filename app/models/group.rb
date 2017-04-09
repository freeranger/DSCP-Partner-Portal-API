class Group < Linkable
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true

  has_and_belongs_to_many :contacts
  has_many :links, dependent: :destroy
  has_many :notes, dependent: :destroy

end
