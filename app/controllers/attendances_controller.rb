class AttendancesController < ApplicationController

  def new

  end

  def create
    if set_user
      if find_group_with_params
        @attendance = Attendance.new(user_id: @user.id, group_id: @group.id)
        if @attendance.save
          redirect_to group_path(@group)
        else
          flash[:message] = "There was a problem joining your group, please try again"
          render group_path(@group)
        end
      else
        flash[:message] = "There was a problem finding your group, please try again"
        redirect_to user_path(@user)
      end
    else
      flash[:message] = "This is only available to users who have logged in. Please login and try again"
      render signin_path
    end
  end

  def delete
    set_user
    find_group_with_params
    @attendance = Attendance.find_by(user_id: @user.id, group_id: @group.id)
    @attendance.destroy
    redirect_to user_path(@user)
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def find_group_with_params
    @group = Group.find(params[:id])
  end

end
