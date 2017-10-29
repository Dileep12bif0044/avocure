class UserController < ApplicationController
  def registration
  end

  def admin_registration
    registration_create_local()
    create_local(@emp.id, @emp.name, 'add_new_members')
    render 'create'
  end

  def create
    if params[:fdata]
      registration_create_local()
      params[:fdata].each do |data|
        if data['add_new_members']
          create_local(@emp.id, @emp.name, data['add_new_members'])
        elsif data['edit_hospital_profile']
          create_local(@emp.id, @emp.name, data['edit_hospital_profile'])
        elsif data['manage_medical_profile']
          create_local(@emp.id, @emp.name, data['manage_medical_profile'])
        else data['respond_to_patient_requests']
          create_local(@emp.id, @emp.name, data['respond_to_patient_requests'])
        end
      end
      @success = "Invitation has been sent to user"
    else
      @permissions = 'Give a permission'
    end
    render 'add_new_members'
  end

  def registration_create_local()
    pass_length = 6;
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
    token = ''
    password = ''
    pass_length.times { password << chars[rand(chars.size)] }

    @email_exists = Employee.where(:email=>params[:email]).first
    @emp = Employee.new
    @emp.name = params[:name]
    @emp.email = params[:email]
    @emp.password = password
    @emp.save
    return @emp
  end

  def create_local(emp_id, emp_name, argData)
    @emp_type = EmployeeType.new
    @emp_type.work_type = argData
    @emp_type.save
    @emp_emp_type = EmployeeEmployeeType.new
    @emp_emp_type.employee_id = emp_id
    @emp_emp_type.employee_type_id = @emp_type.id
    @emp_emp_type.save
    #this is for send mail
    # token_length = 20;
    # token_length.times { token << chars[rand(chars.size)] } 
    # UserMailer.signup_confirmation(emp_name, emp_id).deliver
  end

  def login
  end

  def user_login
    @user = Employee.new
    @user.email = params[:email];
    @user.password = params[:password];
    @db_user = Employee.where(:email=>@user.email).where(:password=>@user.password).first
 
    if !@db_user
      @db_user = "Email or password is not correct, Please try again"
      render "login"
    else 
      @db_emp_type1 = EmployeeEmployeeType.joins(:employee).where(:employees=>{:email=>@user.email, :password=>@user.password}).select('employee_employee_types.employee_type_id')
      @db_emp_type = EmployeeType.where(:id=>@db_emp_type1).select('employee_types.work_type')
      @array = Array.new
      @db_emp_type.each do |x|
        @array.push x.work_type
      end
      if @array.include? 'add_new_members'
        render 'add_new_members'
      elsif @array.include? 'respond_to_patient'
        render 'respond_to_patient'
      elsif @array.include? 'manage_medical_profile'
        render 'manage_medical_profile'
      elsif @array.include? 'edit_hospital_profile'
        render 'edit_hospital_profile'
      end
    end
  end

  def set_password
    @emp = Employee.where(:email=>params[:email])
    if !@emp
      render 'set_one_password'
    elsif params[:password]!= params[:password_confirm]
      @pass = "password does not matched"
      render 'set_one_password'
    else
      @emp.password = pparams[:password]
      @emp.save
      render 'set_one_password'
    end
  end

  def respond_to_patient_requests
  end

  def manage_medical_profile
  end

  def edit_hospital_profile
  end

  def add_new_members
  end

  def set_one_password
  end
end

#this is for storing auth_token for admin
# if argData == 'add_new_members'
#   pass_length = 20;
#   chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
#   token = ''
#   password = ''
#   pass_length.times { tokeno << chars[rand(chars.size)] }
#   @emp_type.auth_token = auth_token
# else
#   @emp_type.auth_token = ''
# end