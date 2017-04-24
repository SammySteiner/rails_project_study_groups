class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_many :notes
end
