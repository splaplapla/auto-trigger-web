class ProconBypassManHostsController < ApplicationController
  def index
    @procon_bypass_man_hosts = ProconBypassManHost.all
  end

  def new
    @procon_bypass_man_host = ProconBypassManHost.new
  end

  def create
    @procon_bypass_man_host = ProconBypassManHost.new(procon_bypass_man_host_params)

    if @procon_bypass_man_host.save
      redirect_to procon_bypass_man_hosts_path, notice: 'Procon Bypass Man Host was successfully created.'
    else
      render :new
    end
  end

  def edit
    @procon_bypass_man_host = ProconBypassManHost.find(params[:id])
  end

  def update
    @procon_bypass_man_host = ProconBypassManHost.find(params[:id])
    if @procon_bypass_man_host.update(procon_bypass_man_host_params)
      redirect_to procon_bypass_man_hosts_path, notice: 'Procon Bypass Man Host was successfully created.'
    else
      render :edit
    end
  end

  private

  def procon_bypass_man_host_params
    params.require(:procon_bypass_man_host).permit(:name, :port, :note)
  end
end
