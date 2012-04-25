class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /projects
  # GET /projects.json
  def index
    @projects = @projects.page(params[:page])
    respond_with @projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_with @project
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = current_user.projects.build({:status => 'open', :deadline => (Time.now + 7.days)})
    respond_with @project
  end

  # GET /projects/1/edit
  def edit
    respond_with @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.create(params[:project])
    respond_with @project
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project.update_attributes(params[:project])
    respond_with @project
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if @project.destroy
      flash[:notice] = "#{@project.class.model_name.human} '#{@project.title}' was successfully destroyed"
    else
      flash[:alert] = "#{@project.class.model_name.human} '#{@project.title}' could not be destroyed"
    end
    respond_with @project
  end

end
