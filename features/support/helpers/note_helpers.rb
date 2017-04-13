def validate_note(data)
  expect(data["content"]).to be_a_kind_of(String)
  expect(data["content"]).to_not be_empty
end