Rails.application.routes.draw do

get 'user/registration'=>'user#registration'
post 'user/admin-registration'=>'user#admin_registration'
post 'user/create'=>'user#create'
post 'user/user-login'=>'user#user_login'
get 'user/login'=>'user#login'
get 'user/set-password'=>'user#set_one_password', as: 'set_password'
post 'user/setting-password'=>'user#set_password'

get 'user/respond-to-patient-requests'=>'user#respond_to_patient_requests', as: 'respond_to_patient_requests'
get 'user/manage-medical-profile'=>'user#manage_medical_profile', as: 'manage_medical_profile'
get 'user/edit-hospital-profile'=>'user#edit_hospital_profile', as: 'edit_hospital_profile'
get 'user/add-new-members'=>'user#add_new_members', as: 'add_new_members'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
