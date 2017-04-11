require 'rails_helper'

RSpec.describe Link, type: :model do
  include_context "db_cleanup_each"

  before do
    group = FactoryGirl.build(:group)
    @link = FactoryGirl.build(:link, :group => group)
  end

  it 'should be valid' do
    expect(@link.valid?).to eq(true)
  end

  it 'should prevent saving with no info' do
    @link = Link.new
    expect(@link.valid?).to eq(false)
  end

  it 'should have a group' do
    @link = FactoryGirl.build(:link)
    expect(@link.valid?).to eq(false)
  end

  it 'should have a title' do
    @link.title = nil
    expect(@link.valid?).to eq(false)
  end

  it 'should have at least 2 chars in the title' do
    @link.title = "a"
    expect(@link.valid?).to eq(false)

    @link.title = "aa"
    expect(@link.valid?).to eq(true)
  end

  it 'should have a destination' do
    @link.destination = nil
    expect(@link.valid?).to eq(false)
  end

  it 'should have a valid URL as the destination, between 12 and 256 characters' do
    @link.destination = "wibble"
    expect(@link.valid?).to eq(false)

    @link.destination = "http://w.com"
    expect(@link.valid?).to eq(true)

    @link.destination = "http://www.a" + "a" * 241 + ".com"
    expect(@link.valid?).to eq(false)

    @link.destination = "http://www.a" + "a" * 240 + ".com"
    expect(@link.valid?).to eq(true)
  end

  it 'should create a new instance in the database' do
    @link.save
    db_link = Link.find(@link.id)
    expect(db_link.title).to eq(@link.title)
    expect(db_link.group).to eq(@link.group)
  end
end
