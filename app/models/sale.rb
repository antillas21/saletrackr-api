class Sale < Transaction
  # relationships
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items

  before_save :calculate_amount
  before_save :calculate_cost
  after_save :update_customer_balance
  after_destroy :update_customer_balance

  def calculate_amount
    items_array = line_items.collect{|item| [item.qty, item.price]}
    total = items_array.inject(0){|sum, item| sum + (item[0] * item[1])}
    self.amount = total
  end

  def calculate_cost
    items_array = line_items.collect{ |item| [item.qty, item.cost] }
    total = items_array.inject(0){ |sum, item| sum + (item[0] * (item[1] || 0)) }
    self.cost = total
  end

  def update_customer_balance
    new_balance = customer.total_sales - customer.total_payments
    customer.update_attribute(:balance, new_balance)
  end

  def email_to_owner!
    SalesMailer.invoice(self, self.customer).deliver
  end
end
