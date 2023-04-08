class RootController < ApplicationController
  def index
  end

  private

  def setting
    @setting ||= Setting.instance
  end

  helper_method :setting
end
