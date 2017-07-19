require 'rails_helper'

RSpec.describe GroupNote, type: :model do
  include_context "db_cleanup_each"
 
  before do
    @user = FactoryGirl.build(:user)
    @note  = FactoryGirl.build(:group_note, :with_group, :user => @user)
  end

  it 'should be valid' do
    @note.valid?
    puts @note.errors.full_messages
    expect(@note.valid?).to eq(true)
  end

  it 'should prevent saving with no info' do
    @note = GroupNote.new
    expect(@note.valid?).to eq(false)
  end

  it 'should have content' do
    @note.content = nil
    expect(@note.valid?).to eq(false)
  end

  it 'should have content of min length 25' do
    @note.content = 'a' * 24
    expect(@note.valid?).to eq(false)

    @note.content = 'a' * 25
    expect(@note.valid?).to eq(true)
  end

  it 'should have a user' do
    @note  = FactoryGirl.build(:group_note)
    expect(@note.valid?).to eq(false)
  end

  it 'should have a group' do
    @note  = FactoryGirl.build(:group_note, :user => @user)
    expect(@note.valid?).to eq(false)
  end

  it 'should create a new instance in the database' do
    @note.save
    db_note = GroupNote.find(@note.id)
    expect(db_note.content).to eq(@note.content)
    expect(db_note.group).to eq(@note.group)
    expect(db_note.user).to eq(@note.user)
  end
end
