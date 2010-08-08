class ChatController < ApplicationController

  before_filter :load_interview

  def show
  end

  def create
    @interview.chat_messages.create! :user => current_user, :message => params[:message]

    render :show
  end

end
