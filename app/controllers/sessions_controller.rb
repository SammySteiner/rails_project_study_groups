class SessionsController < ApplicationController

  def index
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to user_path(@user)
    end
  end

  def new
  end

  def create
    @user = User.find_by(name: params[:user][:name].downcase)
    if @user.present? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "incorrect username/password"
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/'
  end

end
