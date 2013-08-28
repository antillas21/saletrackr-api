class AccountSettingSerializer < ActiveModel::Serializer
  attributes :id, :language, :store_name, :created_at, :updated_at
  has_one :user
end