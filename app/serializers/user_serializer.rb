class UserSerializer < ActiveModel::Serializer
  attributes :id, :names, :email, :password_digest, :created_at, :updated_at
end