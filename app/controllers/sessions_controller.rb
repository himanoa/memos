class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by({id: params[:user_id]})
    if user
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successed'
    else
      redirect_to root_path, alert: 'Login failed'
    end
  end
  def destroy
    if session[:user_id]
      reset_session
      redirect_to root_path, notice: 'Logout successed'
    else
      head :bad_request
    end
  end
end
