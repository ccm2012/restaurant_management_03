class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2]
  include Encode
  ratyrate_rater
  has_many :orders, dependent: :destroy
  has_many :bills
  validates :name, presence: true,
    length: {maximum: Settings.validates.name.maximum}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.validates.email.maximum},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :warning_times, presence: true,
    numericality: {greater_than: Settings.validates.blacklist.greater_than}
  validates :phone_num, presence: true, numericality: true
  after_save :generate_code

  def membership_money_paid
    return 0 unless membership_current
    membership_current.money_paid
  end

  def membership_discount
    return 0 unless membership_current
    membership_current.discount
  end

  def membership_current
    money_paids = MembershipCoupon.coupon_max money_paid
    MembershipCoupon.find_by money_paid: money_paids.max
  end

  def is_blacklist?
    warning_times > Settings.warning_times
  end

  def increase_warning
    update_attributes warning_times: warning_times + 1
  end

  class << self
    def new_with_session params, session
      super.tap do |customer|
        data = session["devise.facebook_data"]
        if data && data["extra"]["raw_info"]
          customer.email = data["email"] if customer.email.blank?
        end
      end
    end

    def from_omniauth aut
      where(provider: aut.provider, uid: aut.uid).first_or_create do |customer|
        auth_info = aut.info
        customer.email = auth_info.email
        customer.password = Devise.friendly_token[0, 20]
        customer.name = auth_info.name
      end
    end
  end
end
