class Note < Linkable
  validates :content, presence: true, length: { minimum: 25 }

  belongs_to :user
  belongs_to :group
end
