class CreateEmployeeTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_types do |t|
      t.string :work_type, null:false

      t.timestamps null: false, :default => Time.now
    end
  end
end
