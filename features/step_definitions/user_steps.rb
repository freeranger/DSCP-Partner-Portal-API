When(/^the system knows about the following user(?:s)?:$/) do |user|
  User.create!(user.hashes)
end

When /^the client authenticates as (.*)$/ do |email|
  user = User.find_by(email: email)
  token = Knock::AuthToken.new(payload: { sub: user.id }).token
  header "Authorization", "Bearer #{token}"
end