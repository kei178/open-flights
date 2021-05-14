require 'ffaker'

FactoryBot.define do
  factory :airline do
    name { FFaker::Company.name }
    image_url { FFaker::Image.url }
  end
end
