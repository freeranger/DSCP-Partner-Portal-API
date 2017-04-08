class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :title
      t.string :destination

      t.timestamps
      
      t.belongs_to :group, index: true
    end
  end
end
