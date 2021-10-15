# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  enum status: { admin: 0, user: 1 }

  # validates :email,uniqueness: {message: "must have unique email"}, if: :current_user
  # validates :fullname, presence: true, allow_blank: false, if: :current_user
  # validates_length_of :fullname, minimum: 2, maximum: 32 ,if: :current_user
end
