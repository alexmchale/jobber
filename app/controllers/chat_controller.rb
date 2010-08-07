class ChatController < ApplicationController

  def show
    @interview = Interview.find(params[:id])
  end

  def create
    @interview = Interview.find(params[:id])
    @interview.append_chat current_user, params[:message]

    render :show
  end

end
