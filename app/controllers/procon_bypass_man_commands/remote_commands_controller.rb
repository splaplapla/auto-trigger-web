class ProconBypassManCommands::RemoteCommandsController < ApplicationController
  def create
    setting = Setting.instance

    if(procon_bypass_man_host = Setting.instance.procon_bypass_man_host).nil?
      render :bad_request
      return
    end

    ProconBypassManCommand.find(params[:procon_bypass_man_command_id]).to_buttons_as_remote.each do |buttons|
      command_response = procon_bypass_man_host.client.send_command(buttons: Array.wrap(buttons))
      Rails.logger.info { command_response } # TODO: commandとresponseを併記する
    end

    head :ok
  end
end
