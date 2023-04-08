class ProconBypassManHost < ApplicationRecord
  validates :name, :port, presence: true

  # @return [ProconBypassManTcpClient]
  def client
    ProconBypassManTcpClient.new(hostname: name, port: port)
  end
end
