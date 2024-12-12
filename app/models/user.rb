class User < ApplicationRecord
  has_secure_password

  validates :email, :presence => true, :uniqueness => true
  validates :password, presence: true, length:  { minimum: 8}, on: :create,
    if: -> { new_record? || changes[:password_digest] }
  validates :names, :presence => true, :length => { :minimum => 3 , :maximum => 50} 

  
end
