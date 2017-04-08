FactoryGirl.define do

  factory :link do
    title          { Faker::Lorem.sentence }
    destination    { Faker::Internet.url }
  end
end