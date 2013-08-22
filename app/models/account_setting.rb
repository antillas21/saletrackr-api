class AccountSetting < ActiveRecord::Base
  # relationships
  belongs_to :user

  # validations
  validates :language, :store_name, presence: true
end
