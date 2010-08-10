class DocumentsController < ApplicationController

  def index
    @interview = Interview.find(params[:interview_id])
    @documents = @interview.documents

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
      format.json { render :json => @documents }
    end
  end

  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
      format.json { render :json => @document }
    end
  end

  def new
    @interview = Interview.find(params[:interview_id])
    @document = Document.new(:interview => @interview)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
      format.json { render :json => @document }
    end
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    interview_id = params[:interview_id] || params[:document].andand[:interview_id]
    template_id = params[:template_id] || params[:document].andand[:template_id]

    @interview = Interview.find(interview_id)
    @template = Template.find(template_id)
    @document = @interview.documents.build(params[:document])
    @document.apply_from_template @template

    respond_to do |format|
      if @document.save
        @interview.update_attributes! :current_document => @document

        format.html { redirect_to(@document, :notice => 'Document was successfully created.') }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
        format.json { render :json => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @document = Document.find(params[:id])

    respond_to do |format|
      if @document.update_attributes(params[:document])
        format.html { redirect_to(@document, :notice => 'Document was successfully updated.') }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
        format.json { render :json => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end

end
