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
  validates      :state, length: { is: 2 }
  validates        :zip, length: { is: 5 }, numericality: { only_integer: true },
                         allow_nil: true

  has_and_belongs_to_many :groups

  pg_search_scope :search, :against => {
                                            :first_name => 'A',
                                            :last_name => 'B',
                                            :email => 'C',
                                            :business_name => 'D',
                                            :street_address => 'D',
                                            :city => 'D',
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
