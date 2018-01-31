FactoryBot.define do
  factory :match do
    day     {Faker::Date.between(2.days.ago, 2.days.from_now)}
  end
end
