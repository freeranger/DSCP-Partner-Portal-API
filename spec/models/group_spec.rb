require 'rails_helper'

RSpec.describe Group, type: :model do
  include_context "db_cleanup_each"
  fixtures :contacts

  before do
    @group  = FactoryGirl.build(:group)
  end

  it 'should be valid' do
    expect(@group.valid?).to eq(true)
  end

  it 'should prevent saving with no info' do
    @group = Group.new
    expect(@group.valid?).to eq(false)
  end

  it 'should have a name' do
    @group.name = nil
    expect(@group.valid?).to eq(false)
  end

  it 'should have a description' do
    @group.description = nil
    expect(@group.valid?).to eq(false)
  end

  it 'should create a new instance in the database' do
    @group.save
    db_group = Group.find(@group.id)
    expect(db_group.name).to eq(@group.name)
    expect(db_group.description).to eq(@group.description)
  end

  it 'should have a unique name' do
    @group.save
    group2 = FactoryGirl.build(:group, :name => @group.name)
    expect(group2.valid?).to eq(false)
  end

  it 'should associate a contact with a group' do
    contact = FactoryGirl.create(:contact)
    @group.contacts << contact
    @group.save
    group_contact = contact.groups.find(@group.id)
    expect(group_contact.id).to eq (@group.id)
  end

  it 'should associate a link with a group' do
    link = FactoryGirl.build(:link)
    @group.links << link
    @group.save
    db_link = Link.find(link.id)
    expect(db_link.group_id).to eq (@group.id)
  end
  
end
