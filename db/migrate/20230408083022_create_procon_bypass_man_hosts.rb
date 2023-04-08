class CreateProconBypassManHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :procon_bypass_man_hosts do |t|
      t.string :name, null: false
      t.integer :port, null: false
      t.text :note, null: true

      t.timestamps
    end
  end
end
