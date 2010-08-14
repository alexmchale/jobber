class ChatController < ApplicationController

  before_filter :load_interview

  def show
    messages = @interview.chat_messages.order(:created_at)
    messages = messages.where("id > ?", params[:after]) if params[:after]

    respond_to do |format|
      format.html
      format.xml  { render :xml => messages }
      format.json { render :json => messages }
    end
  end

  def create
    @cm = @interview.chat_messages.create! :user => current_user, :message => params[:message]

    respond_to do |format|
      format.html { render :show }
      format.xml  { render :xml => @cm }
      format.json { render :json => @cm }
    end
  end

end
