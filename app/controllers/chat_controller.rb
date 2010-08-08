class ChatController < ApplicationController

  def show
    @interview = Interview.find(params[:id])
  end

  def create
    @interview = Interview.find(params[:id])
    @interview.chat_messages.create! :user => current_user, :message => params[:message]

    render :show
  end

end
