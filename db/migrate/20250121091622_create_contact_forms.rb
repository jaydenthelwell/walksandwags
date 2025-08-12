class CreateContactForms < ActiveRecord::Migration[7.2]
  def change
    create_table :contact_forms do |t|
      t.string :service
      t.string :name
      t.string :phone
      t.string :email
      t.string :postcode
      t.text :message
      t.boolean :gdpr_consent

      t.timestamps
    end
  end
end
