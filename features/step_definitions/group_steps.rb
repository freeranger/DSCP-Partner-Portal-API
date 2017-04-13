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

When(/^the group contains contact id (\d*)$/) do |contact_id|
  contact =  Contact.find(contact_id)
  @group.contacts << contact
  @group.save
end