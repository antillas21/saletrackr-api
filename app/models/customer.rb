class Customer < ActiveRecord::Base

  # attr_accessible :name, :phone, :email, :balance
  before_create :assign_uid

  validates :name, presence: true

  belongs_to :user
  has_many :sales, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :transactions

  has_many :line_items, through: :sales

  def total_sales
    self.sales.sum(:amount)
  end

  def total_payments
    self.payments.sum(:amount)
  end

  def generate_uid
    factor = rand(256)
    stamp = Time.now.to_f
    @data = (factor * stamp).to_s[0..7].to_i
  end

  def assign_uid
    generate_uid
    self.uid = @data
  end
end
