When /^the client sends a (GET|DELETE) request to (.*)$/ do |method, path|
  case method
    when 'GET'
      get path
    when 'DELETE'
      delete path
  end
end

When /^the client sends a (POST|PUT) request to (.*):$/ do |method, path, json|
  headers = { 'CONTENT_TYPE' => 'application/json' }
  case method
    when 'PUT'
      put path, json, headers
    when 'POST'
      headers = { 'CONTENT_TYPE' => 'application/json' }
      post path, json, headers
  end
end

Then /^a (#{CAPTURE_STATUS}) status code is returned$/ do |status|
  expect(last_response.status).to eq status
end

Then /^the response should be JSON$/ do
  expect(last_response).to be_json
  #puts JSON.parse(last_response.body)
end

Then /^the JSON(?: response)? should (not)?\s?contain:$/ do |notContain, json|
  expected_item = JSON.parse(json)
  data = JSON.parse(last_response.body)
  # resposne body is an array
  if data.kind_of?(Array)
    # the json I am looking for is an array
    if expected_item.kind_of?(Array)
      matched_items = 0
      # For each item in the expected json, see if you find it in the results
      expected_item.each { |e|
        matched_items += (data.select { |item| item.merge(e) == item }).count >= 1 ? 1 : 0
      }
      expect(matched_items).to be expected_item.length unless notContain == 'not'
      expect(matched_items).to eq 0 if notContain == 'not'
    else
      # the json I am looking for is a single object (in an array of results)
      matched_items = data.select { |item| item.merge(expected_item) == item }
      expect(matched_items.count).to be > 0 unless notContain == 'not'
      expect(matched_items.count).to eq 0 if notContain == 'not'
    end
  else
    # The json I am looking for is in a single item response
    expect(data.merge(expected_item)).to eq data unless notContain == 'not'
    expect(data.merge(expected_item)).to.not eq data if notContain == 'not'
  end
end

Then /^the JSON(?: response)? should contain exactly:$/ do |json|
  expect(last_response.body).to include_json(json)
end

Then(/(at least )?(#{CAPTURE_INT}) (?:.*?) ha(?:s|ve) the following attributes:$/) do |at_least, count, table|
  expected_item = table.hashes.each_with_object({}) do |row, hash|
    name, value, type = row["attribute"], row["value"], row["type"]
    hash[name] = value.to_type(type)
  end
  data = JSON.parse(last_response.body)
  matched_items = data.select { |item| item.merge(expected_item) == item }
  expect(matched_items.count).to eq(count) if at_least.nil?
  expect(matched_items.count).to be >= count unless at_least.nil?
end


Then(/^the JSON(?: response)? should contain a single (.*)/) do |type|
  data = JSON.parse(last_response.body)
  validate_type(data, type)
end

Then(/^the JSON should have at least (#{CAPTURE_INT}) (.*)s/) do |at_least, type|
  data = JSON.parse(last_response.body)
  validate_list(data, type, nil, at_least)
end
