FactoryBot.define do
  factory :match do
    day     {(Date.today)-3..(Date.today)}
  end
end
