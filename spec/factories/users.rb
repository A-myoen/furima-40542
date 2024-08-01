FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email       { Faker::Internet.email }
    password              {'test1234'}
    password_confirmation {'test1234'}
    lastname             {'漢字'}
    firstname            {'ひらがな'}
    lastnamekana        {'カタカナ'}
    firstnamekana       {'カタカナ'}
    birthdate              {Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today)}
  end
end