# frozen_string_literal: true

module ControllerMacros
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:user)
  end

  def login_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user, status: 'user')
  end
end
