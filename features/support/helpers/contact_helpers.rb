def validate_contact(data)
  expect(data["first_name"]).to be_a_kind_of(String)
  expect(data["last_name"]).to_not be_empty
  expect(data["email"]).to be_a_kind_of(String)
end