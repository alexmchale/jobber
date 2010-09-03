class InterviewsController < ApplicationController

  before_filter :authenticate, :except => :show
  before_filter :load_interview, :only => :show

  def index
    @interviews = Interview.user(current_user)

    case @status = params[:status]
    when "finished" then @interviews = @interviews.finished
    when "pending"  then @interviews = @interviews.pending
    when "active"   then @interviews = @interviews.active
    else                 @status     = "all"
    end
  end

  def show
    @templates = current_user.andand.templates
    @documents = @interview.documents
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
