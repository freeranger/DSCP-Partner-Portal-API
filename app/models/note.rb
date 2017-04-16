class Note < Linkable
  validates :content, presence: true, length: { minimum: 25 }
  validates_presence_of :user
  validates_presence_of :group

  belongs_to :user
  belongs_to :group
end
