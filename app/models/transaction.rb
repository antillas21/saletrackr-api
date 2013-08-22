class Transaction < ActiveRecord::Base

  before_create :assign_uid

  # validations
  validates :amount, :customer_id, presence: true

  # realtionships
  belongs_to :customer

  default_scope { order('transactions.created_at ASC') }

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
