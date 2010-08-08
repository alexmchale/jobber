class ApplicationController < ActionController::Base

  include Clearance::Authentication

  protect_from_forgery

protected

  def load_interview
    @interview = Interview.find(params[:id])
    @candidate = @interview.candidate

    raise("unauthorized") if !@interview.authorized?(current_user || params[:access_code])
  end

  def load_document
    @document = Document.find(params[:id])
    @interview = @document.interview
    @candidate = @interview.candidate

    raise("unauthorized") if !@interview.andand.authorized?(current_user || params[:access_code])
  end

end
