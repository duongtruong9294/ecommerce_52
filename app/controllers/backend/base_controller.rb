class Backend::BaseController < ApplicationController
  before_action :admin_user?
  before_action :authenticate_user!
  layout "admin"
end
