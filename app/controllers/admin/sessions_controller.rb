# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create, :top, :about]
      # GET /resource/sign_in
      # def new
      #   super
      # end
        #   def after_sign_in_path_for(resource)
        #       admin_path
        #   end
        #   def after_sign_out_path_for(resource)
        #     about_path
        #   end
        
    def new
    end

    def create
        admin = Admin.find_by(email: params[:session][:email].downcase)
        if admin && admin.authenticate(params[:session][:password])
          sign_in_admin admin
          redirect_to admin_root_path
        else
          flash.now[:danger] = 'Invalid email/password combination'
          render 'new'
        end
    end
    
    def destroy
        sign_out_admin
        redirect_to new_admin_session_path
    end
      
    protected
      # If you have extra params to permit, append them to the sanitizer.
      def configure_sign_in_params
         devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute,:encrypted_password])
      end
end
