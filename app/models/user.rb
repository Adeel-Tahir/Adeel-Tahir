# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  enum status: { admin: 0, user: 1 }

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: { message: ': Email already exist' }
end
