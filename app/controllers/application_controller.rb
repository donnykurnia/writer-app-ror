class ApplicationController < ActionController::Base
  protect_from_forgery
  responders :flash, :http_cache
  respond_to :html, :xml, :json, :js
  check_authorization :unless => :devise_controller?
  helper_method :current_team

  def current_team
    @current_team ||= current_user.team
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => exception.message }
      format.js { render :js => j("alert('#{exception.message}');") }
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => 'Data not found!' }
      format.js { render :js => j("alert('Data not found!');") }
    end
  end
end
