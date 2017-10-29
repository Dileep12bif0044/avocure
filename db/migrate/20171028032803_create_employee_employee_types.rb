class CreateEmployeeEmployeeTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_employee_types do |t|
		t.references :employee_type, index: true, foreign_key: true
		t.references :employee, index: true, foreign_key: true
    	t.timestamps null: false, :default => Time.now
    end
  end
end
