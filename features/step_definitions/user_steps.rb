When(/^the system knows about the following user(?:s)?:$/) do |user|
  User.create!(user.hashes)
end

When /^the client authenticates as ([^\/]*)\/([^\/]*)$/ do |email, password|
  post login_path, { auth: { email: email, password: password } }
  data = JSON.parse(last_response.body)
  token = data['jwt']
  header "Authorization", "Bearer #{token}"
end

When /^the client is not authenticated$/ do
  header "Authorization", "None"
end
