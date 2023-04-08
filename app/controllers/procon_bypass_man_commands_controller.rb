class ProconBypassManCommandsController < ApplicationController
  def index
    @procon_bypass_man_commands = ProconBypassManCommand.all
  end

  def new
    @procon_bypass_man_command = ProconBypassManCommand.new
  end

  def create
    @procon_bypass_man_command = ProconBypassManCommand.new(procon_bypass_man_command_params)

    if @procon_bypass_man_command.save
      redirect_to procon_bypass_man_commands_path, notice: 'ProconBypassManCommand was successfully created.'
    else
      render :new
    end
  end

  def edit
    @procon_bypass_man_command = ProconBypassManCommand.find(params[:id])
  end

  def update
    @procon_bypass_man_command = ProconBypassManCommand.find(params[:id])
    if @procon_bypass_man_command.update(procon_bypass_man_command_params)
      redirect_to procon_bypass_man_commands_path, notice: 'ProconBypassManCommand was successfully created.'
    else
      render :edit
    end
  end

  private

  def procon_bypass_man_command_params
    params.require(:procon_bypass_man_command).permit(:name, :first_buttons, :second_buttons, :repeat_count)
  end
end
