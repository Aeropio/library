class UsersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.where(card_status:"pending")
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #AdminMailer.notify_admin_email.deliver_now
        UserMailer.with(user: @user).sign_up_notification.deliver
        format.html { redirect_to @user, notice: 'Application submitted successfully.' }
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def approve_user
    user = User.where(email: params["email"]).last
    user.card_status = "approved"
    user.save
    UserMailer.with(user: user).approved_notification.deliver
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully approved.' }
      format.json { head :no_content }
    end
  end

  def reject_user
    user = User.where(email: params["email"]).last
    user.card_status = "rejected"
    user.save
    UserMailer.with(user: user).rejected_notification.deliver
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { head :no_content }
    end
  end

  def reports
  end
  
  def get_county_name
    if params["zip"] == '28202'
      is_county = true
    else
      is_county = false
    end
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { render json: {is_county: is_county} }
    end
  end

  def upload_identity_number
    user = User.where(id: params[:id])
    user.identity_number = params[:file]
    user.save
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was rejected.' }
      format.json { render json: {file_uploaded: "success"} }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(User.attribute_names)
    end
end
