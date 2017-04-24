class NotesController < ApplicationController

  def create
    @user = User.find_by(id: session[:user_id])
    @group = Group.find_by(id: params[:note][:group_id])
    @note = Note.new(content: params[:note][:content], attendance:Attendance.find_or_create_by(user: @user, group: @group))
    @note.save
    redirect_to group_path(@group)
  end

end
