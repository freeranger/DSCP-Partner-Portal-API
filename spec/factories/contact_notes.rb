FactoryGirl.define do

  factory :contact_note do
    content    { Faker::Lorem.paragraphs }

    trait :with_user do
      after(:build) do |note|
        note.user = FactoryGirl.build(:user)
      end
    end

    trait :with_contact do
      after(:build) do |note|
        note.contact = FactoryGirl.build(:contact)
      end
    end
  end
end
