require 'rails_helper'

RSpec.describe Contact, type: :model do
  fixtures :contacts

  before do
    @contact = contacts(:stark)
  end

  it 'should be valid' do
    expect(@contact.valid?).to eq(true)
  end

  it 'should have first name' do
    @contact.first_name = "   "
    expect(@contact.valid?).to eq(false)
  end

  it 'should have last name' do
    @contact.last_name = "   "
    expect(@contact.valid?).to eq(false)
  end
end
