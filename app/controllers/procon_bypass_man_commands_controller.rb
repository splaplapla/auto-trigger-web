class ProconBypassManCommandsController < ApplicationController
  def index
    @procon_bypass_man_commands = ProconBypassManCommand.all
  end

  def new
    @procon_bypass_man_command = ProconBypassManCommand.new
  end

  def create
    @procon_bypass_man_command = ProconBypassManCommand.new(procon_bypass_man_host_params)

    if @procon_bypass_man_command.save
      redirect_to procon_bypass_man_hosts_path, notice: 'ProconBypassManCommand was successfully created.'
    else
      render :new
    end
  end
end
