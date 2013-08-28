# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_setting do
    language 'en'
    store_name 'Test Super Store'
  end
end
