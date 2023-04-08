class CreateProconBypassManCommands < ActiveRecord::Migration[7.0]
  def change
    create_table :procon_bypass_man_commands do |t|
      t.string :name, null: false
      t.string :first_buttons, null: false
      t.string :second_buttons, null: true
      t.integer :repeat_count, null: false, default: 1

      t.timestamps
    end
  end
end
