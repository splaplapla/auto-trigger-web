class ProconBypassManHost < ApplicationRecord
  validates :name, :port, presence: true

  cattr_accessor :client_table

  def send_command(buttons: )
    client.send_command(buttons: buttons)
  rescue IOError, Errno::EPIPE
    self.client_table[client_key] = nil
    retry
  end

  private

  # @return [ProconBypassManTcpClient]
  def client
    client_key = [name, port].join
    self.client_table ||= {}
    self.client_table[client_key] ||= ProconBypassManTcpClient.new(hostname: name, port: port)
  end
end
