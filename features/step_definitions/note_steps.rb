When(/^the system knows about the following note(?:s)?:$/) do |note|
  Note.create!(note.hashes)
end

Then(/^the note id (\d+) (does|does not) exist$/) do |id, exists|
  expect(Note.exists?(id)).to be (exists == 'does')
end
