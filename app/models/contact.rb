class Contact < Linkable
  include PgSearch

  VALID_NAME_REGEX = /[a-zA-Z]/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email.downcase! }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX },
                         length: { minimum: 2 }
  validates  :last_name, presence: true, format: { with: VALID_NAME_REGEX },
                         length: { minimum: 2 }
  validates      :email, presence: true, length: { maximum: 255 },
                         format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  validates      :phone, length: { is: 10 }, numericality: { only_integer: true },
                         allow_nil: true
  validates  :phone_alt, length: { is: 10 }, numericality: { only_integer: true },
                         allow_nil: true
  validates        :zip, length: { is: 5 }, numericality: { only_integer: true },
                         allow_nil: true

  has_many :contact_notes
  has_and_belongs_to_many :groups

  default_scope { order(last_name: :asc, first_name: :asc) }

  pg_search_scope :search, :against => {
                                            :first_name => 'A',
                                            :last_name => 'A',
                                            :email => 'B',
                                            :business_name => 'B',
                                            :street_address => 'C',
                                            :city => 'C',
                                            :state => 'D',
                                            :zip => 'D',
                                            :phone => 'D',
                                            :phone_alt => 'D'
                                        },
                                        :using => {
                                          :tsearch => { :prefix => true }
                                        }

  scope :partners, -> { where(partner: true) }
end
