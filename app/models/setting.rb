class Setting < ApplicationRecord
  belongs_to :procon_bypass_man_host, optional: true
end
