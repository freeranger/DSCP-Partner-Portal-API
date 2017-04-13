When(/^the system knows about the following note(?:s)?:$/) do |link|
  Note.create!(link.hashes)
end

Then(/^the location header points to the created note$/) do
  location = last_response.headers['Location']
  expect(location).not_to be_nil
  ids = location.match(/\/groups\/(?<group_id>\d+)\/notes\/(?<id>\d+)/)
  @group = Group.find(ids[:group_id])
  @note = Note.find(ids[:id])

  expect(@group).not_to be_nil
  expect(@note).not_to be_nil
end


Then(/^(?:a|the) note (?:is (?:created|updated) with|has):$/) do |note|
  note.hashes.each do |n|
    expect(Note.exists?(n)).to be true
  end
end

Then(/^the note id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Note.exists?(id)).to be (exists == 'does')
end

