class ApplicationController < ActionController::Base
    before_action :cofigure_permitted_parameters, if: :devise_controller?

    protected

    def cofigure_permitted_parameters
        devise_parameter_sanitizer.permit(:update, keys: [:first_name, :last_name, :url, :mobileno])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :mobileno])

    end
end
