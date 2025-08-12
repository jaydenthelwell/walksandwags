class ContactFormMailer < ApplicationMailer
  default to: "wansteadwags@gmail.com", from: "no-reply@wansteadwags.com"

  def send_contact_email(contact_form)
    @contact_form = contact_form
    mail(subject: "New Contact Form Submission")
  end
end
