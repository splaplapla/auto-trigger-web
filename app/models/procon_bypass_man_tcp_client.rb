class ProconBypassManTcpClient
  # @param [String] hostname
  # @param [Integer] port
  def initialize(hostname: , port: )
    procon_bypass_man_host.port
    @socket = TCPSocket.new(hostname, port) # TODO: キャッシュする
  end

  # @return [String]
  def send_command(buttons: )
    { buttons: buttons }.to_json
  end
end
