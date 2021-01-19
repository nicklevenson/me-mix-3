class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      # t.text :text
      t.integer :mix_id
      t.integer :content_id
      t.timestamps
    end
  end
end
