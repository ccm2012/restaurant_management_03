module Customers
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    attr_reader :customer, :identity

    def google_oauth2
      generic_callback "google_oauth2"
    end

    def generic_callback provider
      @identity = Customer.from_omniauth request.env["omniauth.auth"]

      @customer = identity || current_customer
      if customer.persisted?
        customer_persisted customer, provider
      else
        customer_not_persisted
      end
    end

    def customer_persisted customer, provider
      sign_in_and_redirect customer, event: :authentication
      customer_persisted_flash provider if is_navigational_format?
    end

    def customer_not_persisted
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_customer_registration_url
    end

    def customer_persisted_flash provider
      if provider == "google_oauth2"
        set_flash_message :success, "google"
      else
        set_flash_message :notice, :success, kind: provider.capitalize
      end
    end
  end
end
