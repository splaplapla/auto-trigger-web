class CommandRulesController < ApplicationController
  def update
    @command_rule = CommandRule.find(params[:id])
    if @command_rule.update(command_rule_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def command_rule_params
    params.require(:command_rule).permit(:procon_bypass_man_command_id, :enabled)
  end
end

