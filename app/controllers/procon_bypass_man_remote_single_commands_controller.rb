class ProconBypassManRemoteSingleCommandsController < ApplicationController
  def create
    setting = Setting.instance

    if(procon_bypass_man_host = Setting.instance.procon_bypass_man_host).nil?
      render :bad_request
      return
    end

    command_response = procon_bypass_man_host.client.send_command(buttons: params[:buttons])
    Rails.logger.info { command_response }
    @result = command_response
  rescue => e
    @result = "ERROR: #{e}"
  end
end
