# spec/factories/users.rb
require 'faker'

FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password  {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
    lastname { Faker::Name.last_name }
    firstname { Faker::Name.first_name }
    lastnamekana { Faker::Katakana.random(3) } # 全角カタカナの苗字
    firstnamekana { Faker::Katakana.random(3) } # 全角カタカナの名前
    birthdate { Faker::Date.birthday }
  end
end