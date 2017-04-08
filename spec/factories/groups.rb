FactoryGirl.define do

  factory :group do
    name           { Faker::Lorem.sentence }
    description    { Faker::Lorem.paragraphs }
  end
end