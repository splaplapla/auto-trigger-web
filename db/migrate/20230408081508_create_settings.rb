class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.integer :procon_bypass_man_host_id, null: true
      t.string :capture_device_name, null: true
      t.boolean :capture_enabled, null: false, default: false

      t.timestamps
    end
  end
end
