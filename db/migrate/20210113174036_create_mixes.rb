class CreateMixes < ActiveRecord::Migration[6.1]
  def change
    create_table :mixes do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.boolean :public
      t.string :background_color
      t.string :font_color
      t.timestamps
    end
  end
end
