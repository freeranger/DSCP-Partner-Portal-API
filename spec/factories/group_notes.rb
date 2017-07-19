FactoryGirl.define do

  factory :group_note do
    content    { Faker::Lorem.paragraphs }

    trait :with_user do
      after(:build) do |note|
        note.user = FactoryGirl.build(:user)
      end
    end

    trait :with_group do
      after(:build) do |note|
        note.group = FactoryGirl.build(:group)
      end
    end
  end
end
