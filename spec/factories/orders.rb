FactoryGirl.define do
  factory :order do
    customer_id {Faker::Number.between 1, 10}
    table_id {Faker::Number.between 1, 10}
    code {Digest::MD5.base64digest Faker::Number.between(1, 10).to_s}
    day {Faker::Time.between DateTime.now + 1, DateTime.now + 3000}
    time_in {Faker::Time.forward.hour.to_s << ":00"}
    status {Faker::Number.between 0, 4}
    discount 0
  end
end
