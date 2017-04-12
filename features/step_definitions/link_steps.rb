When(/^the system knows about the following link(?:s)?:$/) do |link|
  Link.create!(link.hashes)
end

Then(/^the location header points to the created link$/) do
  location = last_response.headers['Location']
  expect(location).not_to be_nil
  ids = location.match(/\/groups\/(?<group_id>\d+)\/links\/(?<link_id>\d+)/)
  @group = Group.find(ids[:group_id])
  @link = Link.find(ids[:link_id])
  
  expect(@group).not_to be_nil
  expect(@link).not_to be_nil
end

Then(/^(?:a|the) link is (?:created|updated) with:$/) do |link|
  link.hashes.each do |l|
    expect(Link.exists?(l)).to be true
  end
end

Then(/^the link id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Link.exists?(id)).to be (exists == 'does')
end
