When(/^the system knows about the following group(?:s)?:$/) do |group|
  @group = Group.find(Group.create(group.hashes)[0].id) # This seems like a very dodgy way to get the id, but it works....
end

Then(/^the location header points to the created group/) do
  group = last_response.headers['Location']
  expect(group).not_to be_nil
  ids = group.match(/\/groups\/(?<id>\d+)/)
  @group = Group.find(ids[:id])

  expect(@group).not_to be_nil
end

Then(/^(?:a|the) group is (?:created|updated) with:$/) do |groups|
  groups.hashes.each do |group|
    expect(Group.exists?(group)).to be true
  end
end

Then(/^the group id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Group.exists?(id)).to be (exists == 'does')
end

When(/^the system knows about the following group contacts:$/) do | group_contact|
  group_contact.hashes.each do | gc |
    group = Group.find(gc[:group_id])
    expect(group).not_to be_nil
    contact = Contact.find(gc[:contact_id])
    expect(contact).not_to be_nil
    group.contacts << contact
    group.save
  end
end

And(/^the group contains contact id (\d+)(?: only once)?$/) do |contact_id, once = nil|
  contact = Contact.find(contact_id)
  expect(contact).not_to be_nil
  expect(@group.contacts.exists?(contact.id))
  expect(@group.contacts.count()).to be 1 unless once.nil?
end

And(/^the group does not contain contact id (\d+)$/) do |contact_id|
  contact = Contact.find(contact_id)
  expect(contact).not_to be_nil
  expect(@group.contacts.exists?(contact.id)).to be false
end