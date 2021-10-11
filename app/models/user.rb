# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum status: { admin: 0, user: 1}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_one :cart
  # validates_presence_of :email ,unless: :guest
  # validates_uniqueness_of :username,allow_blank: true, unless: :guest
end
