When(/^the system knows about the following link(?:s)?:$/) do |link|
  Link.create!(link.hashes)
end

Then(/^the link id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Link.exists?(id)).to be (exists == 'does')
end
