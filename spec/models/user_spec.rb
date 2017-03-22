require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :users

  before do
    @user  = users(:quake)
    @user2 = users(:hawkeye)
  end

  it 'should be valid' do
    expect(@user.valid?).to eq(true)
  end

  it 'should have a first name' do
    @user.first_name = "   "
    expect(@user.valid?).to eq(false)
  end

  it 'should have a last name' do
    @user.last_name = "   "
    expect(@user.valid?).to eq(false)
  end

  it 'should have at least 2 chars in names' do
    @user.first_name = "a"
    expect(@user.valid?).to eq(false)

    @user.first_name = "aa"
    expect(@user.valid?).to eq(true)

    @user.last_name = "b"
    expect(@user.valid?).to eq(false)

    @user.last_name = "bb"
    expect(@user.valid?).to eq(true)
  end

  it 'should have proper email format' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |address|
      @user.email = address
      expect(@user.valid?).to eq(true)
    end
  end

  it 'should prevent invalid emails' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com]

    invalid_addresses.each do |address|
      @user.email = address
      expect(@user.valid?).to eq(false)
    end
  end

  it 'should downcase emails before saving' do
    mixed_email = "AvEnGEr@StarkIndusTRIes.Io"

    @user.email = mixed_email
    @user.save

    @user.reload
    expect(@user.email).to eq(mixed_email.downcase)
  end

  it 'should have a unique email' do
    @user2.email = @user.email
    expect(@user2.valid?).to eq(false)
  end

  it 'should encrypt the password' do
    # making sure the password isn't being saved in its exact format
    # trusting rails to handle the encryption
    sample_password = "password"
    new_user = User.create(first_name: "Dwane", last_name: "Johnson",
                           email: "therock@wwe.rocks", password: sample_password,
                           password_confirmation: sample_password)

    expect(new_user.password_digest).to_not eq(sample_password)
  end
end
