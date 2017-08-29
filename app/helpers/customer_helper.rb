module CustomerHelper
  def customer_devise_mapping
    @devise_mapping ||= Devise.mappings[:customer]
  end

  def customer_omniauth_providers
    Customer.omniauth_providers
  end

  def omniauth_utils
    OmniAuth::Utils
  end
end
