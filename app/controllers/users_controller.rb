class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      if @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to signup_path
      end
    else
       @user.errors.full_messages.join(". ")
      render signup_path
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.id == session[:user_id]
      @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:message] = "Please signin to view this page"
      redirect_to signin_path
    end
  end

  def delete
    set_user
    if @user.id == session[:user_id]
      Attendance.all.each do |attendance|
        if attendance.admin_id == @user.id
          attendance.destroy
        end
      end
      flash[:message] = "User: #{@user.name} has been successfully deleted."
      redirect_to signup_path
    else
      flash[:message] = "You can only delete your user account"
      redirect_to signin_path
    end
  end

  def show
    if set_user
      if @user.id == session[:user_id]
        @groups = (Group.where(admin_id: @user.id).order('time') + @user.groups).uniq
      else
        flash[:message] = "Please signin to view this page"
        redirect_to signin_path
      end
    else
      redirect_to signin_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params[:user][:name] = params[:user][:name].downcase
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
