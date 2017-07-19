require 'rails_helper'

RSpec.describe ContactNote, type: :model do
  include_context "db_cleanup_each"
 
  before do
    @user = FactoryGirl.build(:user)
    @note  = FactoryGirl.build(:contact_note, :with_contact, user: @user)
  end

  it 'should be valid' do
    @note.valid?
    puts @note.errors.full_messages
    expect(@note.valid?).to eq(true)
  end

  it 'should prevent saving with no info' do
    @note = ContactNote.new
    expect(@note.valid?).to eq(false)
  end

  it 'should have content' do
    @note.content = nil
    expect(@note.valid?).to eq(false)
  end

  it 'should have a min length of 25' do
    @note.content = 'a' * 24
    expect(@note.valid?).to eq(false)

    @note.content = 'a' * 25
    expect(@note.valid?).to eq(true)
  end

  it 'should have a user' do
    @note  = FactoryGirl.build(:note)
    expect(@note.valid?).to eq(false)
  end

  it 'should have a contact' do
    @note  = FactoryGirl.build(:note, :user => @user)
    expect(@note.valid?).to eq(false)
  end

  it 'should create a new instance in the database' do
    @note.save
    db_note = ContactNote.find(@note.id)
    expect(db_note.content).to eq(@note.content)
    expect(db_note.contact).to eq(@note.contact)
    expect(db_note.user).to eq(@note.user)
  end
end
