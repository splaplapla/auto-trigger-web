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
    Rails.benchmark("[BENCHMARK] ProconBypassManTcpClient#send_command with #{message}") do
      @socket.write(message + "\n")
      command_response = @socket.gets # TODO: これをやめたい
    end
    # @socket.close # 接続をキャッシュしているのでcloseしない
    true
  end

  # @return [void]
  def close
    @socket.close
  end
end
