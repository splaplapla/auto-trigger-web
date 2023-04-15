class ProconBypassManHost < ApplicationRecord
  validates :name, :port, presence: true

  cattr_accessor :client_table

  # @return [ProconBypassManTcpClient]
  def client
    client_key = [name, port].join
    self.client_table ||= {}
    self.client_table[client_key] ||= ProconBypassManTcpClient.new(hostname: name, port: port)
  rescue IOError, Errno::EPIPE
    self.client_table[client_key] = nil
    retry
  end
end
