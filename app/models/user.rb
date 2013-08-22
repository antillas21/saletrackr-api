class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable


  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :account_setting
  has_many :customers
  has_many :payments, through: :customers
  has_many :sales, through: :customers
  has_many :line_items, through: :sales

  before_save :ensure_authentication_token
  after_create :default_account_settings

  private

  def default_account_settings
    self.create_account_setting(language: 'en', store_name: 'My Awesome Store')
  end
end
