class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate
end

