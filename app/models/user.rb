
class User < ApplicationRecord
  has_many :posts
  has_many :comments, dependent: :nullify

  validates :email, presence: true, uniqueness: true
end
