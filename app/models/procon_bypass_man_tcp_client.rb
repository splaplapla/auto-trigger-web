class ProconBypassManTcpClient
  # @param [String] hostname
  # @param [Integer] port
  def initialize(hostname: , port: )
    @socket = TCPSocket.new(hostname, port) # TODO: キャッシュする
  end

  # @param [Array<String>] buttons
  # @return [Boolean]
  def send_command(buttons: )
    message = { buttons: buttons }.to_json
    Rails.benchmark("ProconBypassManTcpClient#send_command with #{message}") do
      @socket.write(message)
    end
    command_response = @socket.gets
    # @socket.close # 接続をキャッシュしているのでcloseしない
    true
  end
end
