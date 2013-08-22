# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coat, class: LineItem do
    name 'French Coat'
    qty 1
    cost 800.0
    price 1200.00
  end

  factory :sweater, class: LineItem do
    name 'Turtle Neck Sweater'
    qty 1
    cost 400.0
    price 650.0
  end

  # :id, :purchase_id, :name, :color, :size, :qty, :cost, :price, :item_total
end
