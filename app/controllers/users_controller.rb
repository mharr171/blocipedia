class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :send_confirmation_instructions, only: [:create]
  after_action :verify_authorized

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    authorize @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    authorize @user

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    authorize @user

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_self_standard
    @user = User.find(params[:id])
    @user.role_id = 1
    make_wikis_public
    authorize @user

    if @user.save
      flash[:notice] = "You've been downgraded to standard. Your private wikis are now public."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error updating your account. Please try again."
      redirect_to edit_user_registration_path
    end
  end

  def make_self_premium
    @user = User.find(params[:id])
    @user.role_id = 2
    authorize @user

    if @user.save
      flash[:notice] = "You've been upgraded to premium. You can now create private wikis."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error updating your account. Please try again."
      redirect_to edit_user_registration_path
    end
  end

  def make_self_admin
    @user = User.find(params[:id])
    @user.role_id = 3
    authorize @user

    if @user.save
      flash[:notice] = "You've been upgraded to admin."
      redirect_to edit_user_registration_path
    else
      flash[:error] = "There was an error updating your account. Please try again."
      redirect_to edit_user_registration_path
    end
  end

  def make_other_standard
    @user = User.find(params[:id])
    @user.role_id = 1
    make_wikis_public
    authorize @user

    if @user.save
      flash[:notice] = "The account has been downgraded to standard. This account's wikis are now public."
      redirect_to user_path(@user)
    else
      flash[:error] = "There was an error updating this account. Please try again."
      redirect_to user_path(@user)
    end
  end

  def make_other_premium
    @user = User.find(params[:id])
    @user.role_id = 2
    authorize @user

    if @user.save
      flash[:notice] = "The account has been upgraded to premium. This account can now create private wikis."
      redirect_to user_path(@user)
    else
      flash[:error] = "There was an error updating this account. Please try again."
      redirect_to user_path(@user)
    end
  end

  def make_other_admin
    @user = User.find(params[:id])
    @user.role_id = 3
    authorize @user

    if @user.save
      flash[:notice] = "The account has been upgraded to admin."
      redirect_to user_path(@user)
    else
      flash[:error] = "There was an error updating this account. Please try again."
      redirect_to user_path(@user)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.fetch(:user, {})
    end

    def make_wikis_public
      @reset_these = Wiki.where(:user_id => current_user.id )
      @cu_id = current_user.id

      @reset_these.each do |r|
        r.private = false
        r.update_attribute(:user_id, @cu_id)
      end
    end
end
