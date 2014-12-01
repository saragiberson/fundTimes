class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :venmo_id
      t.string :venmo_encrypted_token
      t.string :email
      t.string :twitter_id
      t.string :twitter_handle
      t.string :twitter_image_url

      t.timestamps
    end
  end
end
