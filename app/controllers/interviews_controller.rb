class InterviewsController < ApplicationController

  before_filter :authenticate, :except => :show

  def index
  end

  # The show method can be accessed by logged-in users and candidates with the
  # correct access code.
  def show
    @interview = Interview.find(params[:id])
    @candidate = @interview.candidate
    @authorized = @interview.authorized?(current_user || params[:access_code])

    return redirect_to(dashboard_path) if !@authorized
  end

  def new
    @interview = Interview.new(:starts_at => Time.now)
    @interview.candidate = Candidate.new
  end

  def create
    @interview = current_user.interviews.build(params["interview"])

    if current_user.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

end
