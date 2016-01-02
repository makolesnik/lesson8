FactoryGirl.define do
  sequence(:current_email) { |n| "nn24086+#{n}@gmail.com" }
  sequence(:username) { |n| "#{Faker::Internet.user_name(min_length = 3, %w(.))}#{n}2486" }

  factory :user, class: OpenStruct do
    Faker::Config.locale = :en
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    username
    password Faker::Internet.password(min_length = 8)
    mobile_phone '380631867302'
    current_email
  end

  factory :bad_user, class: OpenStruct, parent: :user  do
    username Faker::Internet.user_name(max_length = 5, %w( - _))
    password Faker::Internet.password(max_length = 3)
  end

  factory :user_with_used_phone, class: OpenStruct, parent: :user do
    mobile_phone '380734740643'
  end
end
