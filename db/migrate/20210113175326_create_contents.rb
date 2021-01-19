class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :data_type
      t.string :title
      t.string :creators, array: true, default: []
      t.string :date 
      t.string :image
      t.string :url
      t.string :description
      t.timestamps
    end
  end
end
