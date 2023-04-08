class CommandRule < ApplicationRecord
  belongs_to :procon_bypass_man_command, optional: true
end
