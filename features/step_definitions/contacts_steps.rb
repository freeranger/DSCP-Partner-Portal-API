When(/^the system knows about the following contact(?:s)?:$/) do |contact|
  Contact.create!(contact.hashes)
end

Then(/^the location header points to the created contact/) do
  contact = last_response.headers['Location']
  expect(contact).not_to be_nil
  ids = contact.match(/\/contacts\/(?<id>\d+)/)
  @contact = Contact.find(ids[:id])

  expect(@contact).not_to be_nil
end

Then(/^(?:a|the) contact is (?:created|updated) with:$/) do |contacts|
  contacts.hashes.each do |contact|
    expect(Contact.exists?(contact)).to be true
  end
end

Then(/^the contact id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Contact.exists?(id)).to be (exists == 'does')
end
