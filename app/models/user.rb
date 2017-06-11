class User < ApplicationRecord
  has_secure_password

  has_many :attendances
  has_many :groups, through: :attendances
  has_many :notes, through: :attendances
  has_many :created_groups, :class_name => "Group", :foreign_key => 'admin_id'

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness: true
end
