class CreateMixContents < ActiveRecord::Migration[6.1]
  def change
    create_table :mix_contents do |t|
      t.integer :mix_id
      t.integer :content_id
      t.timestamps
    end
  end
end
