require 'ffaker'

FactoryBot.define do
  factory :airline do
    name { FFaker::Company.name }
    image_url { FFaker::Image.url }

    trait :with_reviews do
      reviews { build_list :review, 3 }
    end

    factory :airline_with_reviews, traits: %i[with_reviews]
  end
end
