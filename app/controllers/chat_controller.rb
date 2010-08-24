class ChatController < ApplicationController

  before_filter :load_interview

  def show
    messages = @interview.chat_messages.order(:created_at).includes(:user)
    messages = messages.where("id > ?", params[:after]) if params[:after]
    messages = messages.where(:channel => "public") if !@interview.authorized?(current_user)

    messages =
      messages.map do |cm|
        { :id         => cm.id,
          :time       => cm.created_at.to_s(:short),
          :channel    => cm.channel,
          :name       => cm.user.andand.email,
          :message    => cm.message }
      end

    respond_to do |format|
      format.html
      format.xml  { render :xml => messages }
      format.json { render :json => messages }
    end
  end

  def create
    channel = "private" if params[:channel] == "private"
    channel = "public" if !channel || !@interview.authorized?(current_user)

    options = {
      :user    => current_user,
      :message => params[:message],
      :channel => channel
    }

    @cm = @interview.chat_messages.create!(options)

    respond_to do |format|
      format.html { render :show }
      format.xml  { render :xml => @cm }
      format.json { render :json => @cm }
    end
  end

end
