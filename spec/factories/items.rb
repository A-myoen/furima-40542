FactoryBot.define do
  factory :item do
    itemname {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    category_id {2}
    condition_id {2}
    postage_id {2}
    prefecture_id {2}
    shippingcost_id {2}
    price { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/1.jpg'), filename: '1.jpg')
    end
  end
end

