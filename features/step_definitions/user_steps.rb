When(/^the (?:following user(?:s)? (?:is|are) registered|system knows about the following user):$/) do |user|
  User.create!(user.hashes)
end

When /^the client authenticates as ([^\/]*)\/([^\/]*)$/ do |email, password|
  post login_path, { auth: { email: email, password: password } }
  data = JSON.parse(last_response.body)
  token = data['jwt']
  header "Authorization", "Bearer #{token}"
  @user = User.find_by(email: email)
end

When /^the client is not authenticated$/ do
  header "Authorization", "None"
end
