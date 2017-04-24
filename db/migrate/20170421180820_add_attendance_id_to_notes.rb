class AddAttendanceIdToNotes < ActiveRecord::Migration[5.0]
  def change
    add_reference :notes, :attendance, foreign_key: true
  end
end
