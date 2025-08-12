class ContactForm
  include ActiveModel::Model

  attr_accessor :service, :name, :phone, :email, :postcode, :message, :gdpr_consent

  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end
