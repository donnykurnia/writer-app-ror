class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = @users.paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.build_team
    @user.role = 'writer'

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    authorize! :assign_roles, @user if params[:user][:role]
    authorize! :assign_team, @user if params[:user][:team_attributes]
    respond_to do |format|
      if @user.update_attributes(params[:user])
        #reset
        @current_ability = nil
        @current_user = nil
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: "User '#{@user.name}' was successfully deleted." }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: "Failed to delete '#{@user.name}'." }
        format.json { head :no_content }
      end
    end
  end

end
