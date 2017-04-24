class Note < ApplicationRecord
  belongs_to :attendance
  delegate :user, :to => :attendance
end
