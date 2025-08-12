class ContactFormsController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end




  private

  def contact_form_params
    params.require(:contact_form).permit(:service, :name, :phone, :email, :postcode, :message, :gdpr_consent)
  end
end
