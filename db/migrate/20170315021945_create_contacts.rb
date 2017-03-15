class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.integer :phone,         limit: 8
      t.integer :phone_alt,     limit: 8
      t.string  :website
      t.string  :facebook
      t.string  :instagram
      t.string  :street_address
      t.string  :city,           default: "St. Charles"
      t.string  :state,          default: "IL"
      t.integer :zip,            limit: 4
      t.string  :business_name
      t.boolean :partner,        default: false
      t.timestamps
    end
    add_index :contacts, :first_name
    add_index :contacts, :last_name
    add_index :contacts, :email, unique: true
    add_index :contacts, :business_name
  end
end
