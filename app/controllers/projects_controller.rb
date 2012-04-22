class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  #before_filter :find_project, :only => [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /projects
  # GET /projects.json
  def index
    @projects = @projects.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = current_user.projects.build({:status => 'open', :deadline => (Time.now + 7.days)})

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.build(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    respond_to do |format|
      if @project.destroy
        format.html { redirect_to projects_url, notice: "Project '#{@project.title}' was successfully deleted." }
        format.json { head :no_content }
      else
        format.html { redirect_to projects_url, alert: "Failed to delete project '#{@project.title}'." }
        format.json { head :no_content }
      end
    end
  end

  protected

    def find_project
      @project = Project.find(params[:id])
    end

end
