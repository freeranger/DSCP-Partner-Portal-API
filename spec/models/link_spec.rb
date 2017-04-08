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

  it 'should have a destination' do
    @link.destination = nil
    expect(@link.valid?).to eq(false)
  end

  it 'should create a new instance in the database' do
    @link.save
    db_link = Link.find(@link.id)
    expect(db_link.title).to eq(@link.title)
    expect(db_link.group).to eq(@link.group)
  end
end
