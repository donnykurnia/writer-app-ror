class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = @users.page(params[:page])
    respond_with @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_with @user
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new({:role => 'writer'})
    @user.build_team
    respond_with @user
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.create(params[:user])
    respond_with @user
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    authorize! :assign_roles, @user if params[:user][:role]
    authorize! :assign_team, @user if params[:user][:team_attributes]
    @user.update_attributes(params[:user])
    respond_with @user
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.destroy
      flash[:notice] = "User '#{@user.name}' was successfully destroyed"
    else
      flash[:alert] = "User '#{@user.name}' could not be destroyed"
    end
    respond_with @user
  end

end
