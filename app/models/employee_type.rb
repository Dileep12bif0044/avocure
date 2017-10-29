class EmployeeType < ApplicationRecord
	has_many :employee_employee_types
	has_many :employees, through: :employee_employee_types
	validates :work_type, presence: true
	# attr_accessor :work_type
end
