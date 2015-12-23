# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    association :contact
    # phone {'123-555-1234'}
    #
    # factory :home_phone do
    #   phone_type 'home'
    # end
    # factory :work_phone do
    #   phone_type 'work'
    # end
    # factory :mobile_phone do
    #   phone_type 'mobile'
    # end

    phone { Faker::PhoneNumber.phone_number }
  end
end
