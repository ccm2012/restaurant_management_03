class SessionsController < Devise::SessionsController
  skip_before_action :verify_signed_out_user, only: :destroy
  respond_to :json

  def create
    self.resource = warden.authenticate! auth_options
    sign_in_and_redirect resource_name, resource
  end

  def sign_in_and_redirect resource_or_scope, resource
    scope = Devise::Mapping.find_scope! resource_or_scope
    resource ||= resource_or_scope
    sign_in scope, resource unless warden.user(scope) == resource
    flash[:success] = t "devise.success"
    render json: {success: true}.to_json
  end

  def failure
    warden.custom_failure!
    render json: {success: false, errors: [t("devise.incorrect")]}.to_json
  end

  def destroy
    super
  end

  protected

  def auth_options
    {scope: resource_name, recall: "#{controller_path}#failure"}
  end
end
