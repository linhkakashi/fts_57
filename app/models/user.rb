class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
      omniauth_providers: [:facebook, :google_oauth2]

  validates :name, presence: true, length: {maximum: 45}
  has_many :exams
  has_many :questions

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.save!
    end
  end

  def self.new_with_session params, session
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
