class CreateProconBypassManCommands < ActiveRecord::Migration[7.0]
  def change
    create_table :procon_bypass_man_commands do |t|
      t.string :name, null: false
      t.string :buttons, null: false

      t.timestamps
    end
  end
end
