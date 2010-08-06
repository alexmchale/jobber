class InterviewsController < ApplicationController

  before_filter :authenticate

  def index
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
