FactoryGirl.define do

  factory :contact do
    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name  }
    email           { Faker::Internet.email }
    phone           { Faker::Number.number(10) } # Can't use Faker::PhoneNumber because we store as a number
    phone_alt       { Faker::Number.number(10) } # Can't use Faker::PhoneNumber because we store as a number
    website         { Faker::Internet.url }
    facebook        { Faker::Internet.user_name }
    instagram       { Faker::Internet.user_name }
    street_address  { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state_abbr }
    zip             { Faker::Number.number(5) }  # Can't use Faker::Address.zip because we store zip as a number
    business_name   { Faker::Company.name }
    partner         { Faker::Boolean.boolean }

  end
end
