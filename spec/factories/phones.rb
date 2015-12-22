# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
    contact nil
    phone "MyString"
    phone_type "MyString"
  end
end
