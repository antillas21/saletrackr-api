class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name, :email, :phone, :balance, :created_at, :updated_at
end