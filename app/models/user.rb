# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy

  enum status: { admin: 0, user: 1 }

  # def admin?
  #   status.eql?('admin')
  # end

  # def user?
  #   status.eql?('user')
  # end

end
