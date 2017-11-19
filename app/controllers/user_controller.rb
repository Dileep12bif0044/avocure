class UserController < ApplicationController
  @@max_time_stamp = (Time.now.to_i+24*60*60).to_i
  def registration
  end

  def admin_registration
    registration_create_local()
    if !@emp.errors.any? && !@exist
      create_local(@emp.email, @emp.id, @emp.name, 'add_new_members')
    end
    render 'registration'
  end

  def create
    if params[:auth_token]
      db_time_stamp = Employee.where(:auth_token=>params[:auth_token]).first
      @auth_token = params[:auth_token]
      if (db_time_stamp && db_time_stamp.time_stamp).to_i < @@max_time_stamp
        if params[:fdata]
          registration_create_local()
          if !@emp.errors.any?
            params[:fdata].each do |data|
              if data['add_new_members']
                create_local(@emp.email, @emp.id, @emp.name, data['add_new_members'])
              elsif data['edit_hospital_profile']
                create_local(@emp.email, @emp.id, @emp.name, data['edit_hospital_profile'])
              elsif data['manage_medical_profile']
                create_local(@emp.email, @emp.id, @emp.name, data['manage_medical_profile'])
              else data['respond_to_patient_requests']
                create_local(@emp.email, @emp.id, @emp.name, data['respond_to_patient_requests'])
              end
            end
            @permissions = 'Invitation has been sent to user'
          end
        else
          @permissions = 'Select a check box for permission'
        end
      else
        @permissions = 'Your session has been expired, Please login again !'
      end
    elsif !params[:auth_token]
      @permissions = 'You are not loggedin, Please login'
    end
    render 'add_new_members'
  end

  def registration_create_local()
    @emp = Employee.where(:email=>params[:email]).first
    if !@emp
      pass_length = 6;
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      token = ''
      password = ''
      pass_length.times { password << chars[rand(chars.size)] }
      @emp = Employee.create(:name=>params[:name], :email=>params[:email], :password=>password)
    else
      @exist = 1
    end
    return @emp, @exist
  end

  def create_local(email_id, emp_id, emp_name, work_type)
    @emp_type = EmployeeType.new
    @emp_type.work_type = work_type
    @emp_type.save
    @emp_emp_type = EmployeeEmployeeType.new
    @emp_emp_type.employee_id = emp_id
    @emp_emp_type.employee_type_id = @emp_type.id
    @emp_emp_type.save

    #this is for send mail
    # chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
    # token_length = 20;
    # token_length.times { token << chars[rand(chars.size)] } 
    # UserMailer.signup_confirmation(emp_name, email_id).deliver
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
      pass_length = 10;
      chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
      auth_token = ''
      pass_length.times { auth_token << chars[rand(chars.size)] }
      @db_user.auth_token = auth_token
      @db_user.time_stamp = Time.now.to_i
      @db_user.save 
      @auth_token = auth_token 

      @db_emp_type1 = EmployeeEmployeeType.joins(:employee).where(:employees=>{:email=>@user.email, :password=>@user.password}).select('employee_employee_types.employee_type_id')
      @db_emp_type = EmployeeType.where(:id=>@db_emp_type1).select('employee_types.work_type')
      @array = Array.new
      @db_emp_type.each do |x|
        @array.push x.work_type
      end
      if auth_token
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
# if work_type == 'add_new_members'
#   pass_length = 20;
#   chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
#   token = ''
#   password = ''
#   pass_length.times { tokeno << chars[rand(chars.size)] }
#   @emp_type.auth_token = auth_token
# else
#   @emp_type.auth_token = ''
# end