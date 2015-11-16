class Account::ApplicationController < ApplicationController
  before_action :authenticate_user!

  private

  def authenticate_user!
    return if current_user

    redirect_to root_path
  end
end
