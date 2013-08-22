class Payment < Transaction

  after_save :update_customer_balance
  after_destroy :update_customer_balance

  def update_customer_balance
    new_balance = customer.total_sales - customer.total_payments
    customer.update_attribute(:balance, new_balance)
  end
end
