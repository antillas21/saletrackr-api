# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

default_user = FactoryGirl.create(:user, email: 'user@example.com')

10.times do
  FactoryGirl.create(:customer, user: default_user)
end

Customer.find_each do |customer|
  3.times do
    coats = rand(1..3)
    sweaters = rand(1..4)
    li = FactoryGirl.build(:coat, qty: coats)
    lo = FactoryGirl.build(:sweater, qty: sweaters)
    customer.sales.create(line_items: [li, lo])
  end

  2.times do
    amount = rand(900..2000)
    customer.payments.create(amount: amount)
  end
end
