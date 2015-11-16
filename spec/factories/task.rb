FactoryGirl.define do
  factory :task do
    name { generate :string }
    description { generate :string }

    trait :with_user do
      user
    end
  end
end
