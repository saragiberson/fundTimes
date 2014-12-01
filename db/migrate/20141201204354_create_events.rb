class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string   :name
      t.string   :location
      t.datetime :date_of_event
      t.string   :image
      t.string   :external_link
      t.integer  :total_price
      t.text     :description
      t.integer  :max_users
      t.integer  :min_users
      t.boolean  :paid, default: false

      t.timestamps
    end
  end
end
