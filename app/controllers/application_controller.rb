class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json{head :forbidden, content_type: "text/html"}
      format.html{redirect_to main_app.root_url, notice: exception.message}
      format.js{head :forbidden, content_type: "text/html"}
    end
  end
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :current_ability, unless: :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_locale, :category_all, :load_search_product

  # rescue_from ActiveRecord::RecordNotFound, NoMethodError, with: :not_found?

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_found?
    render file: "#{Rails.root}/public/404.html", status: 403, layout: false
  end

  private

  def after_sign_in_path_for resource
    resource.admin? ? backend_path : root_path
  end

  def admin_user?
    redirect_to root_path unless current_user.admin?
  end

  def category_all
    @categories = Category.all
  end

  def load_search_product
    @q = Product.ransack params[:q]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: User::SIGN_UP_PARAMS)
  end

  def current_ability
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
    Ability.new(current_user, controller_namespace)
  end
end
