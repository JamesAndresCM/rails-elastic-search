require 'faker'

FactoryBot.define do
  factory :article do
    title { Faker::Name.name }
    text { Faker::Quotes::Shakespeare.hamlet_quote }
  end
end
