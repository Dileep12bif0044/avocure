class CreateEmployees < ActiveRecord::Migration[5.1]
  def change
    create_table :employees do |t|
      t.string :email, unique: true, null:false
      t.string :name
      t.string :password, null:false
      t.timestamps null: false, :default => Time.now
    end
  end
end
