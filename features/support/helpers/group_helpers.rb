def validate_group(data)
  expect(data["name"]).to be_a_kind_of(String)
  expect(data["name"]).to_not be_empty
end