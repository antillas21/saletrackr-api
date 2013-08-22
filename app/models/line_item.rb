class LineItem < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :qty, :price, presence: true

  belongs_to :sale

  before_save :calculate_sale_total
  before_save :calculate_cost_total
  after_save :update_sale
  after_destroy :update_sale

  def calculate_sale_total
    self.item_sale_total = self.qty * self.price
  end

  def calculate_cost_total
    self.item_cost_total = self.qty * self.cost
  end

  def update_sale
    self.sale.save
  end
end
