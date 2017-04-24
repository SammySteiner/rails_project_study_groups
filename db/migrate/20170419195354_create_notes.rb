class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.integer :group_id
      t.text :content
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false

      t.timestamps
    end
  end
end
