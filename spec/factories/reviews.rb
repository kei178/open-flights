require 'ffaker'

FactoryBot.define do
  factory :review do
    association :airline
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.sentence }
    score { rand(1..5) }
  end
end
