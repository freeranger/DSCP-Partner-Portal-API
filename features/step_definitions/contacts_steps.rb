When(/^the system knows about the following contact(?:s)?:$/) do |contact|
  Contact.create!(contact.hashes)
end

Then(/^(?:a|the) contact is (?:created|updated) with:$/) do |contacts|
  puts contacts.hashes
  contacts.hashes.each do |contact|
    expect(Contact.exists?(contact)).to be true
  end
end

Then(/^the contact id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Contact.exists?(id)).to be (exists == 'does')
end
