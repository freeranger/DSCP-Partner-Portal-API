RSpec::Matchers.define :be_json do
  match do |actual|
      expect(actual.header['Content-Type']).to include ('application/json')
    end

    failure_message do |actual|
      "Expected Content-Type to be 'application/json' but was #{actual.header['Content-Type']}'."
    end

    description do
      "Expects Content-Type to be application/json"
    end
end
