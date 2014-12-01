class CreateUserEvents < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :role, default: :user
      t.boolean :payment_status, default: false

      t.timestamps
    end
  end
end
