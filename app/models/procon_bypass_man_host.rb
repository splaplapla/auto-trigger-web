class ProconBypassManHost < ApplicationRecord
  validates :name, :port, presence: true

  # @return [ProconBypassManTcpClient]
  def self.client
    raise('must have a procon_bypass_man_host') if procon_bypass_man_host.nil?

    ProconBypassManTcpClient.new(hostname: procon_bypass_man_host.name, port: procon_bypass_man_host.port)
  end
end
