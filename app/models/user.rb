class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User
end
