class ProconBypassManHost < ApplicationRecord
  validates :name, :port, presence: true

  cattr_accessor :client_table

  def send_command(buttons: )
    Timeout.timeout(3) do
      client.send_command(buttons: buttons)
    end
  rescue IOError, Errno::EPIPE
    self.client_table[client_key] = nil
    Rails.logger.error { e }
    retry
  rescue Timeout::Error
    client&.close
    raise 'timeoutによって通信に失敗しました'
  end

  private

  # @return [ProconBypassManTcpClient]
  def client
    self.client_table ||= {}
    self.client_table[client_key] ||= ProconBypassManTcpClient.new(hostname: name, port: port)
  end

  def client_key
    [name, port].join
  end
end
