class RootController < ApplicationController
  def index
    @setting = Setting.instance
  end
end
