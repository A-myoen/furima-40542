FactoryBot.define do
  factory :order_form do
    postcode        { "111-1111" }
    prefecture_id  {2}
    city           { "江別" }
    street         {"1-1-1"}
    phone          {"07000000000"}
    building       {"aaa"}
    token {"tok_X"}
  end
end