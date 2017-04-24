class GroupsController < ApplicationController

  def index
    set_user
    @groups = Group.order(time: :DESC)
  end

  def new
    @group = Group.new
    set_user
  end

  def create
    set_user
    @group = Group.new(params.require(:group).permit(:topic, :location, :time, :admin_id))
    if @group.save
      Attendance.create(user_id: @user.id, group_id: @group.id)
      flash[:message] = "Study Group: #{@group.topic} successfully created!"
      redirect_to group_path(@group)
    else
      flash[:message] = "Please fill out all the fields."
      render :new
    end
  end

  def edit
    if set_user
      find_group_with_params
      if @user.id == @group.admin_id
      else
        flash[:message] = "You need to be the creator of a Study Group to edit the event."
        redirect_to user_path(@user)
      end
    else
      flash[:message] = "You need to be signed in to edit an event."
      redirect_to signin_path
    end
  end

  def update
    set_user
    find_group_with_params
    if @user.id == params[:group][:admin_id].to_i
      @group.update(params.require(:group).permit(:topic, :location, :time, :admin_id))
      redirect_to group_path(@group)
    else
      flash[:message] = "You need to be the creator of a Study Group to edit the event."
      redirect_to user_path(@user)
    end
  end

  def delete
    set_user
    find_group_with_params
    if @user.id == @group.admin_id
      flash[:message] = "Study Group: #{@group.topic} successfully deleted"
      @group.destroy
      redirect_to user_path(@user)
    else
      flash[:message] = "You need to be the creator of a Study Group to edit the event."
      redirect_to user_path(@user)
    end
  end

  def show
    if set_user
      @note = Note.new
      find_group_with_params
      @attendance = Attendance.new
    else
      flash[:message] = "Please sign in to see Study Group details"
      redirect_to signin_path
    end
  end

  private

  def set_user
    @user = User.find_by(id: session[:user_id])
  end

  def find_group_with_params
    @group = Group.find(params[:id])
  end

end
