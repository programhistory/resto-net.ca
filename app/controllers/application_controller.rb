class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :subdomains

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || cookies[:locale] || :en
    cookies[:locale] = I18n.locale unless cookies[:locale] == I18n.locale
  end
      
  def subdomains
    %w(edmonton gatineau montreal ottawa toronto vancouver)
  end

end
