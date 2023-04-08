class ProconBypassManCommandsController < ApplicationController
  def create
    setting = Setting.instance

    if setting.procon_bypass_man_host.nil?
      render :bad_request
      return
    end

    ProconBypassManHost.client.send_command(buttons: params[:buttons])
  end
end
