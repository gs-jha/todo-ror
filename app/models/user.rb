class User < ApplicationRecord
    has_many :tasks, dependent: :destroy

    before_save {self.email = email.downcase}
    validates :name, presence: true
    validates :email, presence: true

    has_secure_password
    validates :password, presence: true, length: {minimum:6}
end
