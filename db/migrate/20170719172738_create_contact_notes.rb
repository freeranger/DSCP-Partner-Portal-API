class CreateContactNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_notes do |t|
      t.text :content
      t.belongs_to :user, index: true
      t.belongs_to :contact, index: true
      t.timestamps
    end
  end
end
