class Link < Linkable
  validates :title, presence: true, length: { minimum: 2 }
  validates :destination, presence: true, length: { minimum: 12, maximum: 256 }, :url => true
  validates_presence_of :group
  
  belongs_to :group
end
