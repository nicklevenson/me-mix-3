class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :uid
      t.string :provider
      t.string :image, default: "https://icon-library.net//images/no-user-image-icon/no-user-image-icon-27.jpg"
      t.timestamps
    end
  end
end
