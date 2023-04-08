class CreateCommandRules < ActiveRecord::Migration[7.0]
  def change
    create_table :command_rules do |t|
      t.string :condition_key, null: false
      t.string :condition_name, null: false
      t.integer :procon_bypass_man_command_id, null: true
      t.boolean :enabled, null: false, default: false

      t.timestamps
    end
  end
end
