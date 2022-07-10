class User < ApplicationRecord
    has_many :ledgers,dependent: :destroy
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true,length: { minimum: 6 },on: :create
    validates :name, presence: true
    has_secure_password

    scope :find_name,->(arg){ find(arg).name }
end
