class SettingsController < ApplicationController
  def update
    Setting.instance.update!(procon_bypass_man_host_params)
    redirect_back(fallback_location: root_path)
  end

  private

  def procon_bypass_man_host_params
    params.require(:setting).permit(:procon_bypass_man_host_id, :capture_enabled, :capture_device_name)
  end
end
