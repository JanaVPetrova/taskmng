class SessionsController < ApplicationController
  def new
    @session = SignInForm.new
  end

  def create
    @session = SignInForm.new params[:sign_in_form]

    if @session.valid?
      sign_in @session.user

      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
