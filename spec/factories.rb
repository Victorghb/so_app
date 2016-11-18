FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :question do
    content "Lorem ipsum"
    user
    label "Lorem ipsum"
  end

  factory :answer do
    content "Lorem ipsum"
    user "Username"
  end
end
