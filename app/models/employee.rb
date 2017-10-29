class Employee < ApplicationRecord
	has_many :employee_employee_types
	has_many :employee_types, through: :employee_employee_types
	validates :name, :email, :password, presence: true
	# attr_accessor :name, :email, :password
end
