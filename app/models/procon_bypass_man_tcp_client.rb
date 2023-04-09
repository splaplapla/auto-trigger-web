class ProconBypassManTcpClient
  # @param [String] hostname
  # @param [Integer] port
  def initialize(hostname: , port: )
    @socket = TCPSocket.new(hostname, port) # TODO: キャッシュする
  end

  # @param [Array<String>] buttons
  # @return [String] response
  def send_command(buttons: )
    message = { buttons: buttons }.to_json
    @socket.write(message)
    command_response = @socket.gets
    # @socket.close # 接続をキャッシュしているのでcloseしない
    command_response
  end
end
