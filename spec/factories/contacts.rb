# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    # firstname "John"
    # lastname "Doe"
    # sequence(:email) { |n| "johndoe#{n}@123.com" }

    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }

    after(:build) do |contact|
      [:home_phone, :work_phone, :mobile_phone].each do |phone|
        contact.phones << FactoryGirl.build(:phone,
          phone_type: phone, contact: contact)
      end
    end
  end
end
