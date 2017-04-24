class Group < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  has_many :notes, through: :attendances
  belongs_to :admin, :class_name => 'User'
end
