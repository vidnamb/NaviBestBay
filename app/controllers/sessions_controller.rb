class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      if is_admin?
        redirect_to users_path , notice:'You have been signed in as the administrator.'
      else
        redirect_back_or root_path
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to items_path , notice: 'You have been successfully logged out'
  end


end
