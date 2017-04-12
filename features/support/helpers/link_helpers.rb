def validate_link(data)
  expect(data["title"]).to be_a_kind_of(String)
  expect(data["title"]).to_not be_empty
  expect(data["destination"]).to be_a_kind_of(String)
  expect(data["destination"]).to_not be_empty
end