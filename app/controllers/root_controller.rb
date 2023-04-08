class RootController < ApplicationController
  def index
    @command_conditions = {
      spl3_detect_for_charger: { name: 'ブキ(チャージャー)を使っていて標的にあったら' },
      spl3_detect_for_shooter: { name: 'ブキ(シューター)を使っていて標的にあったら' },
    }
    @command_conditions.each do |key, hash|
      CommandRule.find_or_create_by!(condition_key: key, condition_name: hash[:name])
    end
  end

  private

  def setting
    @setting ||= Setting.instance
  end

  helper_method :setting
end
