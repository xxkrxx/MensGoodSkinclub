class ApplicationController < ActionController::
  before_action :authenticate_user!, except: [:top]
end
