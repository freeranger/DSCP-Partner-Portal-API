class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.text :content
      
      t.timestamps

      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
    end
  end
end
