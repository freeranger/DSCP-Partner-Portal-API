require 'rails_helper'

RSpec.describe Contact, type: :model do
  fixtures :contacts

  before do
    @contact  = contacts(:stark)
    @contact2 = contacts(:parker)
  end

  it 'should be valid' do
    expect(@contact.valid?).to eq(true)
    expect(@contact2.valid?).to eq(true)
  end

  it 'should prevent saving with no info' do
    @contact = Contact.new
    expect(@contact.valid?).to eq(false)
  end

  it 'should have first name' do
    @contact.first_name = "   "
    expect(@contact.valid?).to eq(false)
  end

  it 'should have last name' do
    @contact.last_name = "   "
    expect(@contact.valid?).to eq(false)
  end

  it 'should have at least 2 chars in names' do
    @contact.first_name = "a"
    expect(@contact.valid?).to eq(false)

    @contact.first_name = "aa"
    expect(@contact.valid?).to eq(true)

    @contact.last_name = "b"
    expect(@contact.valid?).to eq(false)

    @contact.last_name = "bb"
    expect(@contact.valid?).to eq(true)
  end

  it 'should have email' do 
    @contact.email = "   "
    expect(@contact.valid?).to eq(false)
  end

  it 'should have proper email format' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |address|
      @contact.email = address
      expect(@contact.valid?).to eq(true)
    end
  end

  it 'should prevent invalid emails' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |address|
      @contact.email = address
      expect(@contact.valid?).to eq(false)
    end
  end

  it 'should downcase emails before saving' do
    mixed_email = "AvEnGEr@StarkIndusTRIes.Io"

    @contact.email = mixed_email
    @contact.save

    @contact.reload
    expect(@contact.email).to eq(mixed_email.downcase)
  end

  it 'should have a unique email' do
    @contact2.email = @contact.email
    expect(@contact2.valid?).to eq(false)
  end

  it 'should default partner status to false' do
    new_contact = Contact.new
    expect(new_contact.partner).to eq(false)
  end

  it 'should update partner status' do
    expect(@contact2.partner).to eq(false)

    @contact2.partner = true
    expect(@contact2.valid?).to eq(true)
  end
end
