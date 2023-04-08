class Setting < ApplicationRecord
  belongs_to :procon_bypass_man_host, optional: true

  # @return [Setting]
  def self.instance
    Setting.last || Setting.create
  end
end
